import '../../../../core/base/dependency.dart';
import '../entity/billing_entitlement.dart';
import '../entity/subscription_plan.dart';
import '../entity/subscription_plan_id.dart';

abstract interface class BillingRepository implements Repository {
  Future<List<SubscriptionPlan>> loadPlans();

  Future<BillingEntitlement?> loadCurrentEntitlement();

  Future<BillingEntitlement> purchase(SubscriptionPlanId planId);

  Future<void> clearEntitlement();
}
