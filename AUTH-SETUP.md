# Email sign-in setup for A World in Motion

This experimental version asks visitors to verify their email before entering the museum. It uses a passwordless sign-in link: visitors enter an email address, receive a link, and click it to open the museum.

## 1. Configure Supabase Auth URLs

In the Supabase Dashboard, open the `feedback-demo` project and go to **Authentication → URL Configuration**.

Set **Site URL** to the production site:

`https://sweep-of-history.vercel.app`

Under **Redirect URLs**, add:

`https://sweep-of-history.vercel.app/**`

For the Vercel preview deployments used to test this branch, also add this preview pattern:

`https://sweep-of-history-*-cl-e-f.vercel.app/**`

If the wildcard does not match the preview hostname shown in Vercel, add the exact preview URL ending in `/**`. Remove temporary preview URLs when they are no longer needed.

The app sends the visitor back to the same site where they requested the link by passing `window.location.origin` as `emailRedirectTo`. Supabase only permits destinations on its Redirect URLs allowlist.

## 2. Check email sign-in settings

In **Authentication → Sign In / Providers → Email**, make sure email sign-in is enabled. This app uses Supabase's passwordless Magic Link flow; it does not ask visitors to create or remember a password.

The visitor enters an email and selects **Send sign-in link**. New visitors are automatically signed up by Supabase. When they click the one-time link, Supabase verifies the email and creates a session. The app then reveals the museum.

## 3. Test the flow

1. Open the Vercel preview for this branch. If Vercel Deployment Protection asks you to sign in, use an account that has access to this preview.
2. Enter an email address whose inbox you can access.
3. Select **Send sign-in link**.
4. Open the email and click the link.
5. Confirm you return to the same preview URL and the museum becomes visible.
6. Sign out and confirm that the email sign-in screen returns.
7. Request another link and confirm you can sign in again.

A successful Vercel build only proves the static page deployed. You must test the email link end to end to confirm authentication works.

## 4. Email delivery limits

Supabase's built-in email sender is limited and intended for light testing. It may only deliver to authorised addresses associated with the Supabase project and is not suitable for a real public cohort. For general visitors, configure a custom SMTP provider in Supabase before using this on a public site. Do not put SMTP credentials in browser code or commit them to GitHub.

## 5. What this demonstrates — and what it does not

- **Frontend:** the email field, button, status message, and the museum screen.
- **Backend:** Supabase Auth sends the email, verifies the link, and manages the user session.
- **User records:** Supabase Auth maintains the user record, so a separate public profile table is not required for this demonstration.
- **No environment variables needed for this static prototype:** the app uses the existing Supabase project URL and publishable key in the browser code. The publishable key is designed for frontend use; never place a Supabase secret/service-role key or database password in this page.

The sign-in gate is a user-experience gate, not strong protection for confidential content. The museum's static HTML and JavaScript are still delivered to the browser and can be inspected. Truly private content must be fetched from a backend and protected by server-side authorization or appropriate Row Level Security policies.

## 6. Privacy note

This feature creates an account when a visitor requests a sign-in link. Tell visitors why the email is collected, avoid collecting additional information unnecessarily, and provide a way to contact the site owner about their data. Only share access to the Supabase dashboard with people who need it.
