# A World in Motion

A student-curated online museum exploring how objects travelled across the world and changed meaning. This experimental branch adds passwordless email sign-in: visitors request a sign-in link and must open it before the museum interface is revealed.

## App structure

- `index.html`: the museum, interactive journey maps, comparison view, and email sign-in gate
- `AUTH-SETUP.md`: dashboard settings and end-to-end test instructions
- `schema.sql` and `upgrade_feedback_name_email.sql`: retained from the earlier feedback-form exercise; the sign-in gate does not use the public feedback table

## Tools

- **GitHub:** source code and change history
- **Vercel:** hosting and preview deployments
- **Supabase Auth:** creates user records and verifies email sign-in links
- **ChatGPT:** helps inspect, change, and troubleshoot the app
- **Leaflet + OpenStreetMap:** interactive route maps

## How sign-in works

1. A visitor enters their email address.
2. Supabase Auth sends a one-time sign-in link.
3. The visitor clicks the link and returns to the same site.
4. Supabase establishes a session and confirms the email address.
5. The app reveals the museum for the signed-in session.
6. The visitor can sign out; returning to the museum requires another sign-in.

New visitors are automatically registered by Supabase Auth. A separate public profile table is not required for this demonstration; user records are maintained in Supabase's managed `auth.users` schema.

## Supabase setup and testing

Follow [AUTH-SETUP.md](AUTH-SETUP.md) before testing. Configure the project's Site URL and allow the production and preview redirect URLs. Then test with an inbox you can access.

Supabase's default email sender has restrictions and rate limits. To send authentication email to general visitors at scale, configure a custom SMTP provider beforehand.

This static HTML app uses the Supabase Project URL and publishable key in the browser. A publishable key is intended for frontend use, but never put a Supabase secret key, service-role key, SMTP credential, or database password into frontend code.

## Important security boundary

The login gate checks authentication in the browser, but the museum content is still included in the static HTML/JavaScript bundle. This is suitable for demonstrating account creation and email verification, not for protecting confidential content. Truly private content must be served or queried through a backend with authenticated authorization or appropriate Row Level Security policies.

## Privacy

The feature collects email addresses and creates user accounts. Explain why the email is collected, do not request sensitive information, and restrict access to the Supabase dashboard to people who need it.
