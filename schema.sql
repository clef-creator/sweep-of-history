-- Feedback Loop: workshop demo
-- Anonymous visitors can INSERT a short message only.
-- Public visitors cannot SELECT, UPDATE, or DELETE submitted feedback.

create table if not exists public.feedback (
  id uuid primary key default gen_random_uuid(),
  message text not null
    check (char_length(btrim(message)) between 5 and 1000),
  created_at timestamptz not null default now()
);

alter table public.feedback enable row level security;

revoke all on table public.feedback from anon, authenticated;
grant insert on table public.feedback to anon;

drop policy if exists "Allow anonymous feedback submissions" on public.feedback;

create policy "Allow anonymous feedback submissions"
on public.feedback
for insert
to anon
with check (char_length(btrim(message)) between 5 and 1000);
