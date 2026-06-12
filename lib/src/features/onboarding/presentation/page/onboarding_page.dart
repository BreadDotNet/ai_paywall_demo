import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../core/navigation/app_routes.dart';
import '../../../app/application/bloc/app_session_cubit.dart';

final class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  children: [
                    _OnboardingStep(
                      icon: Icons.receipt_long_outlined,
                      title: t.onboarding.screenOneTitle,
                      body: t.onboarding.screenOneBody,
                    ),
                    _OnboardingStep(
                      icon: Icons.lock_outline,
                      title: t.onboarding.screenTwoTitle,
                      body: t.onboarding.screenTwoBody,
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.onboarding.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(t.onboarding.subtitle),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () async {
                          await context
                              .read<AppSessionCubit>()
                              .completeOnboarding();
                          if (context.mounted) {
                            context.goNamed(AppRoutes.paywallName);
                          }
                        },
                        icon: const Icon(Icons.arrow_forward),
                        label: Text(t.onboarding.continueButton),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _OnboardingStep extends StatelessWidget {
  const _OnboardingStep({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 42,
          backgroundColor: colorScheme.primaryContainer,
          foregroundColor: colorScheme.onPrimaryContainer,
          child: Icon(icon, size: 42),
        ),
        const SizedBox(height: 28),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          body,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
