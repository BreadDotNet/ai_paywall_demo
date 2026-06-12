import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../core/navigation/app_routes.dart';

final class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

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
                const Icon(Icons.error_outline, size: 48),
                const SizedBox(height: 16),
                Text(
                  t.navigation.notFoundTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(t.navigation.notFoundBody, textAlign: TextAlign.center),
                const SizedBox(height: 24),
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
