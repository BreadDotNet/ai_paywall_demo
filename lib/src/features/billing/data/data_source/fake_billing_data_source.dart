import '../../../../core/base/dependency.dart';
import '../../domain/entity/billing_entitlement.dart';
import '../../domain/entity/billing_source.dart';
import '../../domain/entity/purchase_receipt.dart';
import '../../domain/entity/subscription_plan.dart';
import '../../domain/entity/subscription_plan_id.dart';

typedef Clock = DateTime Function();

final class FakeBillingDataSource implements DataSource {
  FakeBillingDataSource({Clock? clock}) : _clock = clock ?? DateTime.now;

  final Clock _clock;

  Future<List<SubscriptionPlan>> loadPlans() async {
    return const [
      SubscriptionPlan(
        id: SubscriptionPlanId.monthly,
        title: 'Monthly',
        description: 'Flexible access for a focused review.',
        priceLabel: '4.99 USD',
        periodLabel: 'per month',
        duration: Duration(days: 30),
      ),
      SubscriptionPlan(
        id: SubscriptionPlanId.yearly,
        title: 'Yearly',
        description: 'Best value for long-running demo access.',
        priceLabel: '39.99 USD',
        periodLabel: 'per year',
        badgeLabel: 'Best value - save 33%',
        duration: Duration(days: 365),
      ),
    ];
  }

  Future<BillingEntitlement> purchase(SubscriptionPlanId planId) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    final plan = (await loadPlans()).firstWhere((item) => item.id == planId);
    final purchasedAt = _clock().toUtc();
    final expiresAt = purchasedAt.add(plan.duration);
    final receipt = PurchaseReceipt(
      transactionId: 'local_demo_${purchasedAt.millisecondsSinceEpoch}',
      planId: plan.id,
      purchasedAt: purchasedAt,
      expiresAt: expiresAt,
      source: BillingSource.localDemo,
    );

    return BillingEntitlement(
      isActive: true,
      planId: plan.id,
      startedAt: purchasedAt,
      expiresAt: expiresAt,
      receipt: receipt,
    );
  }
}
