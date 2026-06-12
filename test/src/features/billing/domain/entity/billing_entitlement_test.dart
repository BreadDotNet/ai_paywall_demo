import 'package:ai_paywall_demo/src/features/billing/domain/entity/billing_entitlement.dart';
import 'package:ai_paywall_demo/src/features/billing/domain/entity/billing_source.dart';
import 'package:ai_paywall_demo/src/features/billing/domain/entity/purchase_receipt.dart';
import 'package:ai_paywall_demo/src/features/billing/domain/entity/subscription_plan_id.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'isExpired is true when expiresAt is before the current clock value',
    () {
      final now = DateTime.utc(2026, 1, 10);
      final entitlement = BillingEntitlement(
        isActive: true,
        planId: SubscriptionPlanId.monthly,
        startedAt: DateTime.utc(2025, 12, 1),
        expiresAt: DateTime.utc(2026),
        receipt: PurchaseReceipt(
          transactionId: 'local_demo_1',
          planId: SubscriptionPlanId.monthly,
          purchasedAt: DateTime.utc(2025, 12, 1),
          expiresAt: DateTime.utc(2026),
          source: BillingSource.localDemo,
        ),
      );

      expect(entitlement.isExpired(now), isTrue);
      expect(entitlement.hasAccess(now), isFalse);
    },
  );

  test('hasAccess is true only for active non-expired entitlements', () {
    final now = DateTime.utc(2026, 1, 10);
    final entitlement = BillingEntitlement(
      isActive: true,
      planId: SubscriptionPlanId.yearly,
      startedAt: now,
      expiresAt: now.add(const Duration(days: 365)),
      receipt: PurchaseReceipt(
        transactionId: 'local_demo_2',
        planId: SubscriptionPlanId.yearly,
        purchasedAt: now,
        expiresAt: now.add(const Duration(days: 365)),
        source: BillingSource.localDemo,
      ),
    );

    expect(entitlement.isExpired(now), isFalse);
    expect(entitlement.hasAccess(now), isTrue);
  });
}
