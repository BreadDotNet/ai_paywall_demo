import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/dependency.dart';
import '../../../../core/errors/application_exception.dart';
import '../../../billing/domain/entity/billing_entitlement.dart';
import '../../../billing/domain/repository/billing_repository.dart';
import '../../../onboarding/domain/repository/onboarding_repository.dart';
import 'app_session_state.dart';

final class AppSessionCubit extends Cubit<AppSessionState>
    implements Dependency {
  AppSessionCubit({
    required this.billingRepository,
    required this.onboardingRepository,
  }) : super(const AppSessionState.initial());

  final BillingRepository billingRepository;
  final OnboardingRepository onboardingRepository;

  Future<void> restoreSession() async {
    emit(state.loading());
    try {
      final onboardingCompleted = await onboardingRepository.isCompleted();
      final entitlement = await billingRepository.loadCurrentEntitlement();
      emit(
        state.ready(
          onboardingCompleted: onboardingCompleted,
          entitlement: entitlement,
        ),
      );
    } on ApplicationException catch (error) {
      emit(state.failed(error));
    } catch (error, stackTrace) {
      emit(
        state.failed(
          UnknownException(originalException: error, stackTrace: stackTrace),
        ),
      );
    }
  }

  Future<void> completeOnboarding() async {
    await onboardingRepository.markCompleted();
    emit(
      state.ready(onboardingCompleted: true, entitlement: state.entitlement),
    );
  }

  void activateEntitlement(BillingEntitlement entitlement) {
    emit(state.ready(onboardingCompleted: true, entitlement: entitlement));
  }

  Future<void> clearDemoState() async {
    emit(state.loading());
    try {
      await billingRepository.clearEntitlement();
      await onboardingRepository.clear();
      emit(state.ready(onboardingCompleted: false));
    } on ApplicationException catch (error) {
      emit(state.failed(error));
    } catch (error, stackTrace) {
      emit(
        state.failed(
          UnknownException(originalException: error, stackTrace: stackTrace),
        ),
      );
    }
  }
}
