import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../core/navigation/app_routes.dart';
import '../../../app/application/bloc/app_session_cubit.dart';
import '../../../app/application/bloc/app_session_state.dart';
import '../../../billing/domain/entity/billing_entitlement.dart';
import '../../../billing/domain/entity/subscription_plan_id.dart';

final class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSessionCubit, AppSessionState>(
      builder: (context, state) {
        final entitlement = state.entitlement;
        if (entitlement == null || !entitlement.hasAccess()) {
          return const _MissingEntitlementView();
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(t.home.title),
            actions: [
              TextButton.icon(
                onPressed: () => _confirmReset(context),
                icon: const Icon(Icons.restart_alt),
                label: Text(t.home.resetButton),
              ),
            ],
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Text(
                  t.home.welcome,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                _EntitlementSummary(entitlement: entitlement),
                const SizedBox(height: 24),
                Text(
                  t.home.featuresTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                _FeatureTile(text: t.home.featureOne),
                _FeatureTile(text: t.home.featureTwo),
                _FeatureTile(text: t.home.featureThree),
                _FeatureTile(text: t.home.featureFour),
                _FeatureTile(text: t.home.featureFive),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _confirmReset(BuildContext context) async {
    final shouldReset = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(t.home.resetDialogTitle),
          content: Text(t.home.resetDialogBody),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(t.home.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(t.home.reset),
            ),
          ],
        );
      },
    );

    if (shouldReset != true || !context.mounted) return;
    await context.read<AppSessionCubit>().clearDemoState();
    if (context.mounted) {
      context.goNamed(AppRoutes.onboardingName);
    }
  }
}

final class _EntitlementSummary extends StatelessWidget {
  const _EntitlementSummary({required this.entitlement});

  final BillingEntitlement entitlement;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _SummaryRow(
              label: t.home.subscription,
              value: _planTitle(entitlement.planId),
            ),
            const Divider(height: 24),
            _SummaryRow(
              label: t.home.expires,
              value: _formatDate(entitlement.expiresAt),
            ),
            const Divider(height: 24),
            _SummaryRow(
              label: t.home.receipt,
              value: _maskReceipt(entitlement.receipt.transactionId),
            ),
          ],
        ),
      ),
    );
  }

  static String _formatDate(DateTime value) {
    final utc = value.toUtc();
    final month = utc.month.toString().padLeft(2, '0');
    final day = utc.day.toString().padLeft(2, '0');
    return '${utc.year}-$month-$day';
  }

  static String _maskReceipt(String transactionId) {
    if (transactionId.length <= 10) return transactionId;
    return '...${transactionId.substring(transactionId.length - 10)}';
  }

  static String _planTitle(SubscriptionPlanId planId) {
    return switch (planId) {
      SubscriptionPlanId.monthly => t.paywall.monthlyTitle,
      SubscriptionPlanId.yearly => t.paywall.yearlyTitle,
    };
  }
}

final class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        const SizedBox(width: 16),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}

final class _FeatureTile extends StatelessWidget {
  const _FeatureTile({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.check_circle_outline),
      title: Text(text),
    );
  }
}

final class _MissingEntitlementView extends StatelessWidget {
  const _MissingEntitlementView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.lock_outline, size: 48),
                const SizedBox(height: 16),
                Text(
                  t.paywall.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => context.goNamed(AppRoutes.onboardingName),
                  child: Text(t.navigation.backToStart),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
