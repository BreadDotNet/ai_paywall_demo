import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../core/base/status.dart';
import '../../../../core/navigation/app_routes.dart';
import '../../../../core/di/di_container.dart';
import '../../../app/application/bloc/app_session_cubit.dart';
import '../../../billing/application/bloc/billing_cubit.dart';
import '../../../billing/application/bloc/billing_state.dart';
import '../../../billing/domain/entity/subscription_plan.dart';
import '../../../billing/domain/entity/subscription_plan_id.dart';
import '../../../billing/domain/repository/billing_repository.dart';
import '../widget/subscription_plan_card.dart';

final class PaywallPage extends StatelessWidget {
  const PaywallPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = context.read<DIContainer>().get<BillingRepository>();

    return BlocProvider(
      create: (_) => BillingCubit(repository)..loadPlans(),
      child: BlocConsumer<BillingCubit, BillingState>(
        listenWhen: (previous, current) {
          return previous.entitlement != current.entitlement &&
              current.entitlement != null;
        },
        listener: (context, state) {
          final entitlement = state.entitlement;
          if (entitlement == null) return;
          context.read<AppSessionCubit>().activateEntitlement(entitlement);
          context.goNamed(AppRoutes.homeName);
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        t.paywall.title,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        t.paywall.subtitle,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 24),
                      if (state.status == Status.loading && state.plans.isEmpty)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(32),
                            child: CircularProgressIndicator(),
                          ),
                        )
                      else
                        for (final plan in state.plans) ...[
                          SubscriptionPlanCard(
                            plan: _localizedPlan(plan),
                            isSelected: plan.id == state.selectedPlanId,
                            onTap: () => context
                                .read<BillingCubit>()
                                .selectPlan(plan.id),
                          ),
                          const SizedBox(height: 12),
                        ],
                      if (state.status == Status.failure) ...[
                        const SizedBox(height: 4),
                        _ErrorMessage(message: state.exception?.userMessage),
                      ],
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed:
                              state.selectedPlan == null ||
                                  state.isPurchaseInProgress
                              ? null
                              : () => context
                                    .read<BillingCubit>()
                                    .purchaseSelectedPlan(),
                          icon: state.isPurchaseInProgress
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.lock_open),
                          label: Text(
                            state.isPurchaseInProgress
                                ? t.paywall.purchaseLoading
                                : t.paywall.continueButton,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        t.paywall.legal,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

SubscriptionPlan _localizedPlan(SubscriptionPlan plan) {
  return switch (plan.id) {
    SubscriptionPlanId.monthly => SubscriptionPlan(
      id: plan.id,
      title: t.paywall.monthlyTitle,
      description: t.paywall.monthlyDescription,
      priceLabel: t.paywall.monthlyPrice,
      periodLabel: t.paywall.monthlyPeriod,
      duration: plan.duration,
    ),
    SubscriptionPlanId.yearly => SubscriptionPlan(
      id: plan.id,
      title: t.paywall.yearlyTitle,
      description: t.paywall.yearlyDescription,
      priceLabel: t.paywall.yearlyPrice,
      periodLabel: t.paywall.yearlyPeriod,
      badgeLabel: t.paywall.yearlyBadge,
      duration: plan.duration,
    ),
  };
}

final class _ErrorMessage extends StatelessWidget {
  const _ErrorMessage({required this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: colorScheme.onErrorContainer),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message ?? t.errors.unknown,
                style: TextStyle(color: colorScheme.onErrorContainer),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
