# Self-Service Password Reset (SSPR) in Microsoft Entra ID

## Why Use SSPR?
- **Reduces help-desk calls** by allowing users to reset their own passwords.
- **Minimizes productivity impact** of a forgotten or expired password.
- Users can reset passwords via web browser or Windows sign-in.

## How SSPR Works
1. **Initiate Reset**: User selects **Can't access your account** or goes to the reset portal.
2. **Verification**: Username + CAPTCHA.
3. **Authentication**: Provide configured methods (mobile app code, security questions, etc.).
4. **Reset**: Enter new password.
5. **Notification**: User receives email confirming the reset.

## Authentication Methods
- **Mobile app (notification/code)**
- **Email** (external address)
- **Phone** (mobile or office)
- **Security questions** (least recommended)

### Minimum Number of Methods
- Choose **1** or **2** methods required.
- Admin accounts always need **2** methods.

## Notifications
- **Notify users** on their own resets.
- **Notify admins** when an admin resets another admin’s password.

## Rollout Scope
- **None**: SSPR disabled.
- **Selected**: Enable for a specific group (test group).
- **All**: Enable for all users.

## Licensing
- **Must have** Microsoft Entra ID P1 or P2 for SSPR (forgotten/expired passwords).
- **Writeback** to on-prem AD also requires P1/P2 or Microsoft 365 Apps for Business.

## Hybrid Support
- **SSPR** can write back changes to on-prem AD (via Entra Connect or cloud sync).
- Use side-by-side deployments for different domains if needed.

## Steps to Configure
1. **Enable** SSPR in Azure portal under **Microsoft Entra ID > Password reset**.
2. **Configure** authentication methods (1 or 2) & registration settings.
3. **Set** notifications and customize help desk info.
4. **Test** with a pilot group before rolling out organization-wide.

