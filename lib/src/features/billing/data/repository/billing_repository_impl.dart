import '../../../../core/errors/application_exception.dart';
import '../../boundary/json/billing_entitlement_json_factory.dart';
import '../../domain/entity/billing_entitlement.dart';
import '../../domain/entity/subscription_plan.dart';
import '../../domain/entity/subscription_plan_id.dart';
import '../../domain/repository/billing_repository.dart';
import '../data_source/billing_entitlement_storage.dart';
import '../data_source/fake_billing_data_source.dart';

final class BillingRepositoryImpl implements BillingRepository {
  BillingRepositoryImpl({
    required this.dataSource,
    required this.storage,
    Clock? clock,
    this.jsonFactory = const BillingEntitlementJsonFactory(),
  }) : clock = clock ?? DateTime.now;

  final FakeBillingDataSource dataSource;
  final BillingEntitlementStorage storage;
  final Clock clock;
  final BillingEntitlementJsonFactory jsonFactory;

  @override
  Future<void> clearEntitlement() async {
    try {
      await storage.deleteEntitlement();
    } on ApplicationException {
      rethrow;
    } catch (error, stackTrace) {
      throw UnknownException(originalException: error, stackTrace: stackTrace);
    }
  }

  @override
  Future<List<SubscriptionPlan>> loadPlans() async {
    try {
      return await dataSource.loadPlans();
    } on ApplicationException {
      rethrow;
    } catch (error, stackTrace) {
      throw UnknownException(originalException: error, stackTrace: stackTrace);
    }
  }

  @override
  Future<BillingEntitlement?> loadCurrentEntitlement() async {
    try {
      final json = await storage.readEntitlementJson();
      if (json == null) return null;

      final entitlement = jsonFactory.fromJsonString(json);
      if (!entitlement.hasAccess(clock().toUtc())) {
        await storage.deleteEntitlement();
        return null;
      }

      return entitlement;
    } on FormatException catch (error, stackTrace) {
      await storage.deleteEntitlement();
      throw ApplicationException(
        userMessage: 'Stored entitlement is invalid.',
        originalException: error,
        stackTrace: stackTrace,
      );
    } on ApplicationException {
      rethrow;
    } catch (error, stackTrace) {
      throw UnknownException(originalException: error, stackTrace: stackTrace);
    }
  }

  @override
  Future<BillingEntitlement> purchase(SubscriptionPlanId planId) async {
    try {
      final entitlement = await dataSource.purchase(planId);
      await storage.writeEntitlementJson(jsonFactory.toJsonString(entitlement));
      return entitlement;
    } on ApplicationException {
      rethrow;
    } catch (error, stackTrace) {
      throw UnknownException(originalException: error, stackTrace: stackTrace);
    }
  }
}
