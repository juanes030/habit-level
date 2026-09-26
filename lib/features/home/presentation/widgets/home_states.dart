import 'package:flutter/material.dart';
import 'package:habit_level/app/theme/app_spacing.dart';

class HomeProgressSummary extends StatelessWidget {
  final int completedCount;
  final int totalCount;

  const HomeProgressSummary({
    super.key,
    required this.completedCount,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    if (totalCount == 0) {
      return const SizedBox.shrink();
    }

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text('Progreso de hoy', style: textTheme.labelLarge),
            ),
            Text(
              '$completedCount / $totalCount',
              style: textTheme.titleLarge?.copyWith(color: colorScheme.primary),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.control / 2),
          child: LinearProgressIndicator(
            value: completedCount / totalCount,
            minHeight: 6,
            backgroundColor: colorScheme.primaryContainer,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          '$completedCount de $totalCount hábitos completados hoy',
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class HomeLoadingState extends StatelessWidget {
  const HomeLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Text('Hoy', style: Theme.of(context).textTheme.displaySmall),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Cada día suma.',
          style: Theme.of(context).textTheme.bodyLarge
              ?.copyWith(color: colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpacing.xl),
        for (var index = 0; index < 3; index++) ...[
          Card(
            margin: EdgeInsets.zero,
            elevation: 0,
            color: colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.card),
              side: BorderSide(color: colorScheme.outlineVariant),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SkeletonLine(
                          widthFactor: 0.56,
                          colorScheme: colorScheme,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        _SkeletonLine(
                          widthFactor: 0.82,
                          colorScheme: colorScheme,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _SkeletonLine(
                          widthFactor: 0.42,
                          colorScheme: colorScheme,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      shape: BoxShape.circle,
                    ),
                    child: const SizedBox.square(dimension: 48),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ],
    );
  }
}

class HomeErrorState extends StatelessWidget {
  final VoidCallback onRetry;

  const HomeErrorState({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_off_outlined, size: 40, color: colorScheme.error),
            const SizedBox(height: AppSpacing.md),
            Text(
              'No pudimos cargar tus hábitos',
              textAlign: TextAlign.center,
              style: textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Comprueba tu conexión e inténtalo de nuevo.',
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkeletonLine extends StatelessWidget {
  final double widthFactor;
  final ColorScheme colorScheme;

  const _SkeletonLine({required this.widthFactor, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 12,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(AppRadius.control / 2),
          ),
        ),
      ),
    );
  }
}
