import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_level/app/theme/app_theme.dart';
import 'package:habit_level/features/habits/domain/entities/habit.dart';
import 'package:habit_level/features/habits/presentation/widgets/habit_card.dart';

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  testWidgets('allows completing a pending habit once data is loaded', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(320, 740);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    var completionCount = 0;

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: HabitCard(
              habit: _habit(),
              isCompleted: false,
              completionsLoaded: true,
              onComplete: () => completionCount++,
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byTooltip('Marcar Leer como completado'));
    expect(completionCount, 1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('keeps completion disabled while daily data is loading', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: HabitCard(
            habit: _habit(),
            isCompleted: false,
            completionsLoaded: false,
            onComplete: () {},
          ),
        ),
      ),
    );

    final button = tester.widget<IconButton>(find.byType(IconButton));
    expect(button.onPressed, isNull);
    expect(find.byTooltip('Cargando el progreso de hoy'), findsOneWidget);
  });

  testWidgets('announces a completed habit and disables its action', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: HabitCard(
            habit: _habit(),
            isCompleted: true,
            completionsLoaded: true,
            onComplete: () {},
          ),
        ),
      ),
    );

    expect(find.text('Completado hoy'), findsOneWidget);
    expect(find.byTooltip('Leer: completado hoy'), findsOneWidget);
    expect(
      tester.widget<IconButton>(find.byType(IconButton)).onPressed,
      isNull,
    );
  });
}

Habit _habit() {
  return Habit(
    id: 'habit-1',
    ownerId: 'owner-1',
    title: 'Leer',
    description: 'Unos minutos antes de dormir',
    frequency: 'daily',
    target: 20,
    unit: 'minutes',
    isActive: true,
    createdAt: DateTime(2025),
    updatedAt: DateTime(2025),
  );
}
