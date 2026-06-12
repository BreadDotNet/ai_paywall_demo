import 'package:equatable/equatable.dart';

import 'billing_source.dart';
import 'subscription_plan_id.dart';

final class PurchaseReceipt extends Equatable {
  const PurchaseReceipt({
    required this.transactionId,
    required this.planId,
    required this.purchasedAt,
    required this.expiresAt,
    required this.source,
  });

  final String transactionId;
  final SubscriptionPlanId planId;
  final DateTime purchasedAt;
  final DateTime expiresAt;
  final BillingSource source;

  @override
  List<Object?> get props => [
    transactionId,
    planId,
    purchasedAt,
    expiresAt,
    source,
  ];
}
