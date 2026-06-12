import 'package:equatable/equatable.dart';

import '../../../../core/base/status.dart';
import '../../../../core/errors/application_exception.dart';
import '../../../billing/domain/entity/billing_entitlement.dart';

final class AppSessionState extends Equatable {
  const AppSessionState({
    required this.status,
    required this.onboardingCompleted,
    this.entitlement,
    this.exception,
  });

  const AppSessionState.initial()
    : status = Status.initial,
      onboardingCompleted = false,
      entitlement = null,
      exception = null;

  final Status status;
  final bool onboardingCompleted;
  final BillingEntitlement? entitlement;
  final ApplicationException? exception;

  bool get hasActiveEntitlement => entitlement?.hasAccess() ?? false;

  AppSessionState loading() {
    return AppSessionState(
      status: Status.loading,
      onboardingCompleted: onboardingCompleted,
      entitlement: entitlement,
    );
  }

  AppSessionState ready({
    required bool onboardingCompleted,
    BillingEntitlement? entitlement,
  }) {
    return AppSessionState(
      status: Status.success,
      onboardingCompleted: onboardingCompleted,
      entitlement: entitlement,
    );
  }

  AppSessionState failed(ApplicationException exception) {
    return AppSessionState(
      status: Status.failure,
      onboardingCompleted: onboardingCompleted,
      entitlement: entitlement,
      exception: exception,
    );
  }

  @override
  List<Object?> get props => [
    status,
    onboardingCompleted,
    entitlement,
    exception,
  ];
}
