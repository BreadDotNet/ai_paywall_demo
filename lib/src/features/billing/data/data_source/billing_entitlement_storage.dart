import '../../../../core/base/dependency.dart';

abstract interface class BillingEntitlementStorage implements DataSource {
  Future<String?> readEntitlementJson();

  Future<void> writeEntitlementJson(String json);

  Future<void> deleteEntitlement();
}
