import 'package:equatable/equatable.dart';

import 'purchase_receipt.dart';
import 'subscription_plan_id.dart';

final class BillingEntitlement extends Equatable {
  const BillingEntitlement({
    required this.isActive,
    required this.planId,
    required this.startedAt,
    required this.expiresAt,
    required this.receipt,
  });

  final bool isActive;
  final SubscriptionPlanId planId;
  final DateTime startedAt;
  final DateTime expiresAt;
  final PurchaseReceipt receipt;

  bool isExpired([DateTime? now]) {
    final clockValue = now ?? DateTime.now().toUtc();
    return !expiresAt.toUtc().isAfter(clockValue.toUtc());
  }

  bool hasAccess([DateTime? now]) => isActive && !isExpired(now);

  @override
  List<Object?> get props => [isActive, planId, startedAt, expiresAt, receipt];
}
