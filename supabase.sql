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
