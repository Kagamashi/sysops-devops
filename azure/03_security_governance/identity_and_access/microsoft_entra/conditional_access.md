# Microsoft Entra Conditional Access

## Overview
Conditional Access is a security feature in **Microsoft Entra ID** that controls access to resources based on **identity signals**, such as:
- **User identity** (who is requesting access)
- **Location** (where the request is coming from)
- **Device** (what device is being used)

Conditional Access ensures **security** while allowing users to stay **productive** by enforcing policies dynamically.

---

## Key Benefits
- **Empowers users** to work securely from anywhere.
- **Protects organizational assets** by enforcing policies.
- **Enhances multifactor authentication (MFA)** by making it more adaptive:
  - Users **may not be challenged** for MFA when signing in from a known location.
  - Users **may be required** to complete MFA if the login is unusual or high-risk.

---

## How Conditional Access Works
1. **Signals Collected** – User identity, location, device, and application being accessed.
2. **Decision Made** – Allow full access, block access, or require MFA.
3. **Enforcement Applied** – Grant access, deny access, or require additional authentication.

Example:
- If a user signs in **from an expected location**, they are granted access **without additional verification**.
- If a user signs in **from an unusual location**, they may be **blocked** or required to complete **MFA**.

---

## Use Cases for Conditional Access
- **Require MFA based on role, location, or network** (e.g., admins require MFA, while regular users do not).
- **Restrict access to approved client applications** (e.g., only approved email apps can connect to corporate email).
- **Allow access only from managed devices** that meet security and compliance standards.
- **Block access from untrusted locations** or high-risk sources.
