// ─────────────────────────────────────────────────────────────
// Конфиг Vault. Сюда вставь URL и anon key своего Supabase-проекта.
// Пока строки пустые — облачная синхронизация выключена,
// приложение работает локально (как и раньше).
//
// Как получить:
//   1. supabase.com → New project → дождись подготовки.
//   2. Project settings → API → скопируй "Project URL" и "anon public" key.
//   3. SQL editor → выполни содержимое supabase.sql из этой папки.
//   4. Authentication → Providers:
//        • Email — оставь включённым;
//        • Google — включи и пропиши Client ID/Secret из Google Cloud
//          (Authorized redirect URI бери из Supabase в этом же окне).
//   5. Authentication → URL Configuration → Site URL = адрес твоего
//      деплоя (для GitHub Pages — https://kapopus.github.io/vault/),
//      Redirect URLs — добавь его же и http://localhost:5050/ для дев-сборки.
// ─────────────────────────────────────────────────────────────
window.VAULT_CFG = {
  SUPABASE_URL: 'https://zenqfmjhawjytswiiwfi.supabase.co',      // например: 'https://abcd1234.supabase.co'
  SUPABASE_ANON_KEY: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InplbnFmbWpoYXdqeXRzd2lpd2ZpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODAxNDI3NTMsImV4cCI6MjA5NTcxODc1M30.BNeJrj3KIM7szlZ77DP6Yb5uWD1D89SYJ3gNlevfgIk', // длинный JWT, начинается с 'eyJ...'
};
