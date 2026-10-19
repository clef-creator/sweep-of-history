# Supabase Auth setup for A World in Motion

This app requires visitors to confirm their email before the museum interface is shown.

## 1. Configure the Supabase Auth URLs

In the Supabase Dashboard for the `feedback-demo` project:

1. Open **Authentication → URL Configuration**.
2. Set **Site URL** to:

   `https://sweep-of-history.vercel.app`

3. Under **Redirect URLs**, add:

   `https://sweep-of-history.vercel.app/**`

4. If testing a Vercel Preview deployment, add that exact preview URL with `/**` as well. Remove temporary preview URLs when they are no longer needed.

The app passes `window.location.origin` as the email confirmation redirect. Supabase only permits redirects included in this list.

## 2. Require email confirmation

1. Open **Authentication → Sign In / Providers**.
2. Open the **Email** provider.
3. Make sure email/password sign-in is enabled.
4. Make sure **Confirm email** is enabled.

With confirmation enabled, a new user should receive an email confirmation link. They should not be able to enter the museum until Supabase returns a session with a confirmed email.

## 3. Test the flow

1. Open the deployed app in a private/incognito window.
2. Sign up using an email address you can access and a password of at least eight characters.
3. Check your inbox and click the confirmation link.
4. Confirm the link returns to the museum domain.
5. Confirm the journeys are visible after verification.
6. Sign out and confirm the gate returns.
7. Sign in again and confirm the museum opens without a new sign-up.

## 4. Email delivery limits

Supabase's built-in email service is intended for light testing and has a low sending limit. It may be insufficient for a whole workshop cohort signing up at the same time. For class-wide testing, configure a custom SMTP email provider in Supabase beforehand. Do not assume that every student will receive confirmation emails reliably through the default sender.

## 5. Important security note

The gate checks authentication in the browser, but the museum's content remains part of a static HTML/JavaScript bundle and can be inspected by a technical visitor. This is suitable for demonstrating signup-before-entry. It is not a security boundary for confidential content. Truly private content must be fetched from an authenticated backend and protected by server-side authorization or appropriate RLS policies.

The app requires no public database table for the basic email signup/sign-in workflow; Supabase Auth manages user accounts.
