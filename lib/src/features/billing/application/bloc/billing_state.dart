import 'package:equatable/equatable.dart';

import '../../../../core/base/status.dart';
import '../../../../core/errors/application_exception.dart';
import '../../domain/entity/billing_entitlement.dart';
import '../../domain/entity/subscription_plan.dart';
import '../../domain/entity/subscription_plan_id.dart';

final class BillingState extends Equatable {
  const BillingState({
    required this.status,
    required this.plans,
    this.selectedPlanId,
    this.entitlement,
    this.exception,
    this.isPurchaseInProgress = false,
  });

  const BillingState.initial()
    : status = Status.initial,
      plans = const [],
      selectedPlanId = null,
      entitlement = null,
      exception = null,
      isPurchaseInProgress = false;

  final Status status;
  final List<SubscriptionPlan> plans;
  final SubscriptionPlanId? selectedPlanId;
  final BillingEntitlement? entitlement;
  final ApplicationException? exception;
  final bool isPurchaseInProgress;

  SubscriptionPlan? get selectedPlan {
    final selectedId = selectedPlanId;
    if (selectedId == null) return null;
    for (final plan in plans) {
      if (plan.id == selectedId) return plan;
    }
    return null;
  }

  BillingState copyWith({
    Status? status,
    List<SubscriptionPlan>? plans,
    SubscriptionPlanId? selectedPlanId,
    BillingEntitlement? entitlement,
    ApplicationException? exception,
    bool? isPurchaseInProgress,
  }) {
    return BillingState(
      status: status ?? this.status,
      plans: plans ?? this.plans,
      selectedPlanId: selectedPlanId ?? this.selectedPlanId,
      entitlement: entitlement ?? this.entitlement,
      exception: exception,
      isPurchaseInProgress: isPurchaseInProgress ?? this.isPurchaseInProgress,
    );
  }

  @override
  List<Object?> get props => [
    status,
    plans,
    selectedPlanId,
    entitlement,
    exception,
    isPurchaseInProgress,
  ];
}
