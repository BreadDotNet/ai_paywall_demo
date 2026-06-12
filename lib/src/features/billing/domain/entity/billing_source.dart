enum BillingSource {
  localDemo('local_demo');

  const BillingSource(this.value);

  final String value;

  static BillingSource fromJson(String value) {
    return values.firstWhere(
      (source) => source.value == value,
      orElse: () => throw FormatException('Unknown billing source: $value'),
    );
  }
}
