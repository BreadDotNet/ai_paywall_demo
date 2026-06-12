# Features

## app

Owns bootstrapping, Material app composition, global Cubit providers, startup session restore, and reset coordination.

## onboarding

Shows two simple onboarding screens and records completion in `SharedPreferences`.

## billing

Provides subscription plans, fake purchase flow, purchase receipt, active entitlement, explicit JSON serialization, secure persistence, and validation.

## paywall

Shows monthly and yearly subscription cards, selects yearly by default, displays a best-value discount label, and runs the emulated purchase flow.

## home

Protected premium screen shown only with an active entitlement. Displays plan, expiration date, masked receipt id, premium demo items, and reset action.
