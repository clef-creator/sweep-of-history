# A World in Motion

A student-curated online museum exploring how objects travelled across the world and changed meaning. Visitors must sign up and confirm their email before the museum interface is revealed.

## Stack

- **GitHub:** stores source code and change history.
- **Vercel:** deploys the website.
- **Supabase Auth:** manages email/password accounts and email verification.
- **ChatGPT:** helps inspect, change, and troubleshoot the app.
- **Leaflet + OpenStreetMap:** interactive route maps.

## How access works

1. A visitor signs up with email and password.
2. Supabase sends a confirmation email.
3. The visitor clicks the confirmation link and returns to the museum URL.
4. The app checks the Supabase session and confirmed-email status before revealing the museum.
5. Returning visitors can sign in, and signed-in visitors can sign out.

Supabase Auth stores account records in its managed `auth.users` schema. **A separate public profile table is not required for this email gate.**

## Supabase setup

Follow `AUTH-SETUP.md` before testing email verification. The required settings include the production Site URL, allowed redirect URLs, and the Email provider's confirmation setting.

This front-end demo uses the Supabase Project URL and publishable key. Never put a Supabase secret/service-role key or database password into browser code.

## Workshop security boundary

The login gate hides the museum interface until the session is authenticated and the email is confirmed. The museum content itself is still delivered as a static page, so this is a user-experience gate rather than strong protection for confidential content. If content must be genuinely private, it needs to be served or queried through a backend with authenticated authorization.

## Note on previous feedback demo files

`schema.sql` and `upgrade_feedback_name_email.sql` belong to the earlier feedback-form exercise. The museum's email sign-up gate does not use the public feedback table. Those files are retained for workshop reference and are not needed for authentication.
