# Architecture

## Boot Chain

`lib/main.dart` calls `bootstrap()`. Bootstrap ensures Flutter binding, creates dependencies, restores `AppSessionCubit`, creates the router, and runs `App`.

## Environment Config

The app uses one config file: `configs/app-config.json`. It currently provides `APP_NAME`. `AppConfig.fromEnvironment()` also has a local default so the app remains easy to run during review.

## Localization

User-facing strings live in `lib/i18n/en.i18n.json`. `dart run slang` generates `lib/i18n/strings.g.dart`. Widgets use the generated `t` accessor.

## Dependency Injection

`DIContainer` is a small type-keyed registry. `create_dependencies.dart` wires config, storage services, repositories, and global Cubits.

## Routing

Routing is direct `go_router`:

- `/onboarding`
- `/paywall`
- `/home`

`createRouter()` chooses the initial location after session restore. Navigation uses named routes with `context.goNamed(...)`.

## State

`AppSessionCubit` owns startup/session decisions and reset. `BillingCubit` owns paywall plan loading, plan selection, purchase loading, purchase success, and purchase failure.

## Billing

The billing feature has domain entities for plans, receipts, and entitlements. `FakeBillingDataSource` emulates local products and purchases. `SecureBillingStorage` persists entitlement JSON in `flutter_secure_storage`. `BillingRepositoryImpl` validates entitlement activity and clears expired or invalid storage.

## Feature Layout

Features use this shape when relevant:

```text
domain/entity/
domain/repository/
data/data_source/
data/repository/
application/bloc/
presentation/page/
presentation/widget/
boundary/json/
```

## Mental Model

Home access is derived from active entitlement only. Onboarding completion can affect demo flow, but it never grants premium access.
