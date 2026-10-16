# Feedback Loop: GitHub + Vercel + Supabase

A tiny static HTML demo for the CLeF AI-assisted development workshop. It collects anonymous feedback and saves each message in Supabase. The public app cannot read submitted messages.

## 1. Create the Supabase table

1. Create a Supabase project.
2. Open the project's SQL Editor.
3. Paste and run `schema.sql`.
4. Confirm that the `feedback` table is present.

The SQL enables Row Level Security and permits anonymous INSERT only. It does not grant public SELECT, UPDATE, or DELETE access.

## 2. Configure the app

In Supabase, copy the **Project URL** and **publishable key** (usually begins with `sb_publishable_`). In `index.html`, replace:

- `PASTE_SUPABASE_PROJECT_URL_HERE`
- `PASTE_SUPABASE_PUBLISHABLE_KEY_HERE`

A publishable key is intended for browser use. **Never place a Supabase secret key or service-role key in frontend code.** Database access is controlled by grants and RLS policies.

## 3. Deploy on Vercel

1. Import this GitHub repository in Vercel.
2. Select the `workshop-feedback-demo` branch.
3. This is a plain HTML site. Choose the **Other** framework preset if prompted; no build command or output directory is required.
4. Deploy and open the generated URL.

## 4. Verify the end-to-end flow

1. Open the deployed URL.
2. Submit a feedback message of at least five characters.
3. In Supabase, open **Table Editor → feedback**.
4. Confirm that the new row appears.

## Troubleshooting

- **Setup needed**: placeholders remain in `index.html`; add the URL and publishable key.
- **Invalid API key**: confirm that the URL and publishable key were copied from the same Supabase project.
- **Permission/RLS error**: confirm that `schema.sql` ran successfully, RLS is enabled, and the anonymous INSERT policy and grant exist.
- **Vercel 404**: ensure `index.html` is in the deployment root and the correct branch was imported.

## Security note

This is a classroom prototype, not a production feedback service. The anonymous insert endpoint can be spammed. Submitted messages are not publicly readable through the app, but anyone can submit messages. Do not collect names, email addresses, confidential or sensitive information. A production app should add appropriate abuse prevention, monitoring and retention controls.
