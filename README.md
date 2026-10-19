# A World in Motion

A student-curated online museum exploring how objects travelled across the world and changed meaning. The app includes interactive journey maps, a comparison view, and a feedback page inside the museum.

## App structure

- `index.html`: the full museum, interactive map journeys, journey comparison, and integrated feedback screen
- `schema.sql`: database schema and Row Level Security policy for feedback submissions
- `upgrade_feedback_name_email.sql`: upgrade script for an older message-only feedback table

## Stack

- **GitHub:** version history and source code
- **Vercel:** hosting and deployment
- **Supabase:** PostgreSQL database and Data API used by the feedback page
- **Leaflet + OpenStreetMap:** interactive route maps

## Feedback data flow

The museum header's **Share feedback** button opens the feedback section without navigating to a separate website. The form collects name, email, and feedback message, then inserts them into Supabase's `public.feedback` table.

Anonymous visitors can INSERT valid feedback only. Row Level Security remains enabled, and the public role has no SELECT, UPDATE, or DELETE privileges on the table.

## Supabase setup for a fresh project

1. Create a Supabase project.
2. Open SQL Editor and run `schema.sql`.
3. Copy the Project URL and publishable key for the app.
4. Replace `SUPABASE_URL` and `SUPABASE_PUBLISHABLE_KEY` in `index.html` with the new project's values.
5. Deploy through Vercel and test a feedback submission.

For an existing table with older submissions, run `upgrade_feedback_name_email.sql` instead of recreating the table. It preserves prior rows while adding the name/email fields and enforcing them for new anonymous inserts.

## Security and privacy

The publishable key is intended for browser use. Never place a Supabase secret key, service-role key, or database password in frontend code.

Names and email addresses are personal data. Tell users why they are collected, limit dashboard access, avoid collecting sensitive information, and decide on a retention period. This workshop prototype does not verify email ownership and its anonymous insert endpoint can be spammed.
