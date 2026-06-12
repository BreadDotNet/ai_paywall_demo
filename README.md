# AI Paywall Demo

A small product-like Flutter demo app showing onboarding, a subscription paywall, local billing simulation, persisted entitlement state, and a protected home screen.

## Assignment Scope

- Android and iOS Flutter app.
- Single environment config in `configs/app-config.json`.
- No backend, no auth, no real billing SDK, and no invented API endpoints.
- Local billing simulation through a dedicated billing domain.
- Active subscription entitlement is required to reach Home.

## Architecture

The app uses a feature-first structure under `lib/src/features/` with small core primitives under `lib/src/core/`.

- `go_router` handles direct routes: `/onboarding`, `/paywall`, and `/home`.
- `flutter_bloc` Cubits own app session state and paywall billing state.
- `DIContainer` is the composition boundary used by `create_dependencies.dart`.
- `slang` provides generated localization from `lib/i18n/en.i18n.json`.
- Billing models are real domain objects, not booleans.

Startup flow:

1. `main.dart` calls `bootstrap()`.
2. `createDependencies()` wires config, storage, repositories, and Cubits.
3. `AppSessionCubit.restoreSession()` loads onboarding state and secure billing entitlement.
4. `createRouter()` chooses `/home` only when the entitlement is active; otherwise it starts at `/onboarding`.

## Project Structure

```text
lib/
  bootstrap.dart
  create_dependencies.dart
  i18n/
  src/core/
  src/features/app/
  src/features/onboarding/
  src/features/billing/
  src/features/paywall/
  src/features/home/
ai-context/
configs/app-config.json
test/src/features/billing/
```

## Billing Model

The billing feature contains:

- `SubscriptionPlan`: monthly and yearly local products.
- `PurchaseReceipt`: local transaction id, plan id, purchase time, expiry, and source.
- `BillingEntitlement`: active state, plan id, start/end dates, receipt, and expiration helpers.
- `BillingRepository`: contract used by app/session and paywall flows.
- `FakeBillingDataSource`: creates local demo purchases with `local_demo_<timestamp>` transaction ids.
- `BillingRepositoryImpl`: validates stored entitlements and clears expired or invalid data.

Monthly expires after about 30 days. Yearly expires after about 365 days. The yearly option is selected by default and marked as best value.

## Secure Persistence

Billing entitlement JSON is stored only in `flutter_secure_storage` with key:

```text
billing.entitlement.v1
```

`SharedPreferences` is used only for non-sensitive demo state:

```text
onboarding.completed.v1
```

Use the Home screen reset action to clear both values and return to onboarding.

## Run

```bash
flutter pub get
dart run slang
flutter run --dart-define-from-file=./configs/app-config.json
```

## Branding

Source branding assets live in `assets/branding/`.

- `app_icon.png` is the full launcher icon source.
- `app_icon_foreground.png` is used for Android adaptive icons.
- `splash_icon.png` and `splash_icon_android12.png` are used by the native splash generator.

Regenerate platform assets after changing the source images:

```bash
dart run flutter_launcher_icons
dart run flutter_native_splash:create
```

## Verify

```bash
dart format --set-exit-if-changed lib test
flutter analyze
flutter test
```

## AI Usage During Development

- Generated bootstrap structure.
- Generated billing domain model.
- Generated Cubit/repository flow.
- Refactored routing/session logic.
- Searched for analyzer issues.
- Improved README and project docs.

## What I Would Improve With More Time

- Real StoreKit and Google Play Billing integration.
- Server-side receipt validation.
- Restore purchases.
- Analytics.
- Remote config and A/B tests.
- More tests for routing, session, billing, and widget flows.
- Better design assets.
- Real onboarding content.

## Agent Context

Future agents should read `ai-context/README.md` before editing `lib/`.
