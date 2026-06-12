# Rules

R1. Target Android and iOS. Keep desktop and web incidental.

R2. Use single-env config in `configs/app-config.json`.

R3. Use `slang` for user-facing strings. Regenerate with `dart run slang` after editing locale JSON.

R4. Use direct `go_router` routes. Avoid complex redirects unless a new product requirement needs them.

R5. Use Cubits for app and billing state.

R6. Use the custom `DIContainer` as the composition boundary.

R7. Keep billing domain separate from UI and session routing.

R8. Store entitlement and receipt JSON only in `flutter_secure_storage` under `billing.entitlement.v1`.

R9. Use `SharedPreferences` only for non-sensitive demo state such as onboarding completion.

R10. Do not add real billing SDKs, auth, backend clients, or fake network endpoints.

R11. Keep docs dry, factual, and easy to review.

R12. Do not add `ai-context/decisions.md`.

R13. Keep launcher icon and native splash assets generated from `assets/branding/` through `flutter_launcher_icons` and `flutter_native_splash`.
