import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_level/features/habits/domain/entities/habit.dart';
import 'package:habit_level/features/habits/presentation/widgets/habit_form.dart';

void main() {
  testWidgets('populates fields from the initial habit', (tester) async {
    final initialHabit = Habit(
      id: 'habit-1',
      ownerId: 'owner-1',
      title: 'Leer',
      description: 'Antes de dormir',
      frequency: 'weekly',
      target: 20,
      unit: 'kilometers',
      isActive: true,
      createdAt: DateTime(2025),
      updatedAt: DateTime(2025),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HabitForm(initialHabit: initialHabit, onSubmit: (_) {}),
        ),
      ),
    );

    final fields = tester.widgetList<TextFormField>(find.byType(TextFormField));
    expect(fields.elementAt(0).controller!.text, 'Leer');
    expect(fields.elementAt(1).controller!.text, 'Antes de dormir');
    expect(fields.elementAt(2).controller!.text, '20');
    expect(find.text('Semanal'), findsOneWidget);
    expect(find.text('Kilómetros'), findsOneWidget);
  });

  testWidgets('validates fields and submits the habit through its callback', (
    tester,
  ) async {
    HabitFormData? submittedData;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HabitForm(onSubmit: (formData) => submittedData = formData),
        ),
      ),
    );

    await tester.tap(find.text('Crear hábito'));
    await tester.pump();

    expect(find.text('Ingresa un nombre'), findsOneWidget);
    expect(find.text('Ingresa un objetivo válido'), findsOneWidget);
    expect(submittedData, isNull);

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), '  Leer  ');
    await tester.enterText(fields.at(2), '20');
    await tester.tap(find.text('Crear hábito'));
    await tester.pump();

    expect(submittedData, isNotNull);
    expect(submittedData!.title, 'Leer');
    expect(submittedData!.target, 20);
    expect(submittedData!.frequency, 'daily');
    expect(submittedData!.unit, 'minutes');
  });
}
