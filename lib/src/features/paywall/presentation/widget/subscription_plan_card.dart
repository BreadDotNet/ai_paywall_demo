import 'package:flutter/material.dart';

import '../../../billing/domain/entity/subscription_plan.dart';

final class SubscriptionPlanCard extends StatelessWidget {
  const SubscriptionPlanCard({
    required this.plan,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final SubscriptionPlan plan;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final borderColor = isSelected
        ? colorScheme.primary
        : colorScheme.outlineVariant;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: borderColor, width: isSelected ? 2 : 1),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      plan.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Icon(
                    isSelected
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: isSelected
                        ? colorScheme.primary
                        : colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
              if (plan.badgeLabel != null) ...[
                const SizedBox(height: 8),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: colorScheme.tertiaryContainer,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    child: Text(
                      plan.badgeLabel!,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: colorScheme.onTertiaryContainer,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 12),
              Text(plan.description),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    plan.priceLabel,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Text(plan.periodLabel),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
