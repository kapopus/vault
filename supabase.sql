-- Vault: схема для облачной синхронизации.
-- Выполнить один раз в Supabase SQL Editor.
--
-- Идея простая: одна строка на пользователя, всё состояние — в jsonb.
-- Подход подходит для текущего размера данных и не требует миграций
-- при добавлении новых полей в S.

create table if not exists public.user_states (
  user_id    uuid primary key references auth.users(id) on delete cascade,
  state      jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

-- RLS: каждый видит и правит только свою строку.
alter table public.user_states enable row level security;

drop policy if exists "own row select" on public.user_states;
drop policy if exists "own row insert" on public.user_states;
drop policy if exists "own row update" on public.user_states;
drop policy if exists "own row delete" on public.user_states;

create policy "own row select" on public.user_states
  for select using (auth.uid() = user_id);

create policy "own row insert" on public.user_states
  for insert with check (auth.uid() = user_id);

create policy "own row update" on public.user_states
  for update using (auth.uid() = user_id);

create policy "own row delete" on public.user_states
  for delete using (auth.uid() = user_id);

-- ─────────────────────────────────────────────────────────────
-- Удаление собственного аккаунта.
-- Клиенту нельзя дёргать admin API (нет service-ключа), поэтому
-- делаем SECURITY DEFINER функцию: она выполняется с правами владельца
-- и удаляет текущего пользователя из auth.users. Каскад по FK заодно
-- сносит его строку из user_states.
create or replace function public.delete_user()
returns void
language sql
security definer
set search_path = public, auth
as $$
  delete from auth.users where id = auth.uid();
$$;

revoke all on function public.delete_user() from public, anon;
grant execute on function public.delete_user() to authenticated;
