import 'dart:convert';

import '../../domain/entity/billing_entitlement.dart';
import '../../domain/entity/billing_source.dart';
import '../../domain/entity/purchase_receipt.dart';
import '../../domain/entity/subscription_plan_id.dart';

final class BillingEntitlementJsonFactory {
  const BillingEntitlementJsonFactory();

  BillingEntitlement fromJsonString(String source) {
    final decoded = jsonDecode(source);
    if (decoded is! Map<String, Object?>) {
      throw const FormatException('Entitlement JSON must be an object.');
    }
    return fromJson(decoded);
  }

  String toJsonString(BillingEntitlement entitlement) {
    return jsonEncode(toJson(entitlement));
  }

  BillingEntitlement fromJson(Map<String, Object?> json) {
    final receiptJson = _readMap(json, 'receipt');
    return BillingEntitlement(
      isActive: _readBool(json, 'isActive'),
      planId: SubscriptionPlanId.fromJson(_readString(json, 'planId')),
      startedAt: _readDateTime(json, 'startedAt'),
      expiresAt: _readDateTime(json, 'expiresAt'),
      receipt: PurchaseReceipt(
        transactionId: _readString(receiptJson, 'transactionId'),
        planId: SubscriptionPlanId.fromJson(_readString(receiptJson, 'planId')),
        purchasedAt: _readDateTime(receiptJson, 'purchasedAt'),
        expiresAt: _readDateTime(receiptJson, 'expiresAt'),
        source: BillingSource.fromJson(_readString(receiptJson, 'source')),
      ),
    );
  }

  Map<String, Object?> toJson(BillingEntitlement entitlement) {
    return {
      'isActive': entitlement.isActive,
      'planId': entitlement.planId.value,
      'startedAt': entitlement.startedAt.toUtc().toIso8601String(),
      'expiresAt': entitlement.expiresAt.toUtc().toIso8601String(),
      'receipt': {
        'transactionId': entitlement.receipt.transactionId,
        'planId': entitlement.receipt.planId.value,
        'purchasedAt': entitlement.receipt.purchasedAt
            .toUtc()
            .toIso8601String(),
        'expiresAt': entitlement.receipt.expiresAt.toUtc().toIso8601String(),
        'source': entitlement.receipt.source.value,
      },
    };
  }

  static bool _readBool(Map<String, Object?> json, String key) {
    final value = json[key];
    if (value is bool) return value;
    throw FormatException('Expected bool at $key.');
  }

  static DateTime _readDateTime(Map<String, Object?> json, String key) {
    return DateTime.parse(_readString(json, key)).toUtc();
  }

  static Map<String, Object?> _readMap(Map<String, Object?> json, String key) {
    final value = json[key];
    if (value is Map<String, Object?>) return value;
    throw FormatException('Expected object at $key.');
  }

  static String _readString(Map<String, Object?> json, String key) {
    final value = json[key];
    if (value is String && value.isNotEmpty) return value;
    throw FormatException('Expected non-empty string at $key.');
  }
}
