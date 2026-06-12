import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/status.dart';
import '../../../../core/errors/application_exception.dart';
import '../../domain/entity/subscription_plan_id.dart';
import '../../domain/repository/billing_repository.dart';
import 'billing_state.dart';

final class BillingCubit extends Cubit<BillingState> {
  BillingCubit(this._repository) : super(const BillingState.initial());

  final BillingRepository _repository;

  Future<void> loadPlans() async {
    emit(state.copyWith(status: Status.loading, exception: null));
    try {
      final plans = await _repository.loadPlans();
      emit(
        state.copyWith(
          status: Status.success,
          plans: plans,
          selectedPlanId: plans.isEmpty ? null : plans.last.id,
          exception: null,
        ),
      );
    } on ApplicationException catch (error) {
      emit(state.copyWith(status: Status.failure, exception: error));
    } catch (error, stackTrace) {
      emit(
        state.copyWith(
          status: Status.failure,
          exception: UnknownException(
            originalException: error,
            stackTrace: stackTrace,
          ),
        ),
      );
    }
  }

  void selectPlan(SubscriptionPlanId planId) {
    emit(state.copyWith(selectedPlanId: planId, exception: null));
  }

  Future<void> purchaseSelectedPlan() async {
    final selectedPlanId = state.selectedPlanId;
    if (selectedPlanId == null) return;

    emit(
      state.copyWith(
        status: Status.loading,
        isPurchaseInProgress: true,
        exception: null,
      ),
    );

    try {
      final entitlement = await _repository.purchase(selectedPlanId);
      emit(
        state.copyWith(
          status: Status.success,
          entitlement: entitlement,
          isPurchaseInProgress: false,
          exception: null,
        ),
      );
    } on ApplicationException catch (error) {
      emit(
        state.copyWith(
          status: Status.failure,
          isPurchaseInProgress: false,
          exception: error,
        ),
      );
    } catch (error, stackTrace) {
      emit(
        state.copyWith(
          status: Status.failure,
          isPurchaseInProgress: false,
          exception: UnknownException(
            originalException: error,
            stackTrace: stackTrace,
          ),
        ),
      );
    }
  }
}
