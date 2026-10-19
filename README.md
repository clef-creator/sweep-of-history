# Feedback Loop: GitHub + Vercel + Supabase

A small static HTML demo for the CLeF AI-assisted development workshop. It collects a name, email address, and feedback message, then saves each submission in Supabase. The public app cannot read the saved submissions.

## Current app architecture

- **GitHub:** source files and version history on `workshop-feedback-demo`
- **Vercel:** hosts the frontend
- **Supabase:** PostgreSQL database and API
- **Frontend connection:** Supabase Project URL and publishable key are in `index.html`. The publishable key is designed for browser use; never put a secret/service-role key or database password in frontend code.

## 1. Set up Supabase for a new project

1. Create a Supabase project.
2. Open the project's SQL Editor.
3. Paste and run `schema.sql`.
4. Confirm that `feedback` has `name`, `email`, `message`, `id`, and `created_at`.

## 2. Upgrade the existing project

If your table previously contained only message and timestamp fields, run `upgrade_feedback_name_email.sql` in Supabase SQL Editor. It adds the two fields and updates the insert policy without deleting earlier submissions.

RLS remains enabled. Anonymous visitors may INSERT only when name, email, and message pass validation; they cannot read, update, or delete saved submissions through the API.

## 3. Deploy on Vercel

1. Import or connect the GitHub repository in Vercel.
2. Use the `workshop-feedback-demo` branch for this demo.
3. This is plain HTML. Choose the **Other** framework preset if prompted; no build command or output directory is required.
4. Deploy and open the generated URL.

## 4. Verify the end-to-end flow

1. Open the deployed URL.
2. Submit a name, a valid email address, and a feedback message of at least five characters.
3. In Supabase, open **Table Editor → feedback**.
4. Confirm the new row contains all three values.

## Troubleshooting

- **Setup needed:** placeholders remain in `index.html`; configure the Supabase URL and publishable key.
- **Invalid API key:** confirm the URL and publishable key came from the same project.
- **Permission/RLS error:** confirm the schema was applied, RLS is enabled, and the anonymous INSERT policy and grant exist.
- **Vercel 404:** ensure `index.html` is in the deployment root and the correct branch is deployed.

## Privacy and security note

This is a classroom prototype. Names and email addresses are personal data. Explain why they are being collected, limit dashboard access, decide how long to retain them, and do not collect sensitive information. Anonymous submissions can be spammed, and the form does not verify that the email address belongs to the submitter. A production app needs appropriate abuse prevention and a clear privacy/retention process.
