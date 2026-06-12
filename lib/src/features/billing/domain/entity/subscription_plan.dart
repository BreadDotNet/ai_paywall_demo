import 'package:equatable/equatable.dart';

import 'subscription_plan_id.dart';

final class SubscriptionPlan extends Equatable {
  const SubscriptionPlan({
    required this.id,
    required this.title,
    required this.description,
    required this.priceLabel,
    required this.periodLabel,
    required this.duration,
    this.badgeLabel,
  });

  final SubscriptionPlanId id;
  final String title;
  final String description;
  final String priceLabel;
  final String periodLabel;
  final String? badgeLabel;
  final Duration duration;

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    priceLabel,
    periodLabel,
    badgeLabel,
    duration,
  ];
}
