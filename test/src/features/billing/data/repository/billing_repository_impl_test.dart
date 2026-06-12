import 'package:ai_paywall_demo/src/features/billing/data/data_source/billing_entitlement_storage.dart';
import 'package:ai_paywall_demo/src/features/billing/data/data_source/fake_billing_data_source.dart';
import 'package:ai_paywall_demo/src/features/billing/data/repository/billing_repository_impl.dart';
import 'package:ai_paywall_demo/src/features/billing/domain/entity/subscription_plan_id.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('purchase creates and persists an active entitlement', () async {
    final now = DateTime.utc(2026, 1, 1, 12);
    final storage = InMemoryBillingEntitlementStorage();
    final repository = BillingRepositoryImpl(
      dataSource: FakeBillingDataSource(clock: () => now),
      storage: storage,
      clock: () => now,
    );

    final entitlement = await repository.purchase(SubscriptionPlanId.yearly);
    final reloaded = await repository.loadCurrentEntitlement();

    expect(entitlement.planId, SubscriptionPlanId.yearly);
    expect(entitlement.receipt.transactionId, 'local_demo_1767268800000');
    expect(entitlement.expiresAt, now.add(const Duration(days: 365)));
    expect(reloaded?.hasAccess(now), isTrue);
    expect(storage.savedJson, isNotNull);
  });

  test('loadCurrentEntitlement clears expired stored entitlement', () async {
    final purchaseTime = DateTime.utc(2026, 1, 1);
    final loadTime = purchaseTime.add(const Duration(days: 31));
    final storage = InMemoryBillingEntitlementStorage();
    final purchaseRepository = BillingRepositoryImpl(
      dataSource: FakeBillingDataSource(clock: () => purchaseTime),
      storage: storage,
      clock: () => purchaseTime,
    );
    await purchaseRepository.purchase(SubscriptionPlanId.monthly);

    final loadRepository = BillingRepositoryImpl(
      dataSource: FakeBillingDataSource(clock: () => loadTime),
      storage: storage,
      clock: () => loadTime,
    );

    final entitlement = await loadRepository.loadCurrentEntitlement();

    expect(entitlement, isNull);
    expect(storage.savedJson, isNull);
  });
}

final class InMemoryBillingEntitlementStorage
    implements BillingEntitlementStorage {
  String? savedJson;

  @override
  Future<void> deleteEntitlement() async {
    savedJson = null;
  }

  @override
  Future<String?> readEntitlementJson() async {
    return savedJson;
  }

  @override
  Future<void> writeEntitlementJson(String json) async {
    savedJson = json;
  }
}
