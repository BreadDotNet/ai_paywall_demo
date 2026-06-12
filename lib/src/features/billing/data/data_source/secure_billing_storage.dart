import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'billing_entitlement_storage.dart';

final class SecureBillingStorage implements BillingEntitlementStorage {
  const SecureBillingStorage(this._storage);

  static const entitlementKey = 'billing.entitlement.v1';

  final FlutterSecureStorage _storage;

  @override
  Future<void> deleteEntitlement() {
    return _storage.delete(key: entitlementKey);
  }

  @override
  Future<String?> readEntitlementJson() {
    return _storage.read(key: entitlementKey);
  }

  @override
  Future<void> writeEntitlementJson(String json) {
    return _storage.write(key: entitlementKey, value: json);
  }
}
