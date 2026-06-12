enum SubscriptionPlanId {
  monthly('monthly'),
  yearly('yearly');

  const SubscriptionPlanId(this.value);

  final String value;

  static SubscriptionPlanId fromJson(String value) {
    return values.firstWhere(
      (planId) => planId.value == value,
      orElse: () => throw FormatException('Unknown subscription plan: $value'),
    );
  }
}
