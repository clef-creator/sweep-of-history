-- Upgrade the existing feedback-demo table to accept name + email.
-- Run in Supabase SQL Editor if your database previously collected message only.
alter table public.feedback
  add column if not exists name text
  check (name is null or char_length(btrim(name)) between 1 and 120);

alter table public.feedback
  add column if not exists email text
  check (email is null or (char_length(btrim(email)) <= 254 and btrim(email) ~* '^[^[:space:]@]+@[^[:space:]@]+[.][^[:space:]@]+$'));

alter table public.feedback enable row level security;
revoke all on table public.feedback from anon, authenticated;
grant insert on table public.feedback to anon;

drop policy if exists "Allow anonymous feedback submissions" on public.feedback;
create policy "Allow anonymous feedback submissions"
on public.feedback
for insert to anon
with check (
  name is not null
  and char_length(btrim(name)) between 1 and 120
  and email is not null
  and char_length(btrim(email)) <= 254
  and btrim(email) ~* '^[^[:space:]@]+@[^[:space:]@]+[.][^[:space:]@]+$'
  and char_length(btrim(message)) between 5 and 1000
);
