# Agent Rules

- Read `ai-context/README.md` before opening `lib/`.
- Treat `ai-context/` as the project knowledge layer.
- If code and `ai-context/` conflict, trust code as current state and update docs or ask before changing behavior.
- Keep generated docs plain and factual.
- Billing/subscription state must stay in `flutter_secure_storage`, not `SharedPreferences`.
- Do not add a backend, auth flow, real billing SDK, or fake network layer unless explicitly requested.
