import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/habit_completion.dart';

class HabitCompletionModel extends HabitCompletion {
  const HabitCompletionModel({
    required super.id,
    required super.habitId,
    required super.ownerId,
    required super.date,
    required super.completedAt,
    required super.value,
  });

  factory HabitCompletionModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;

    return HabitCompletionModel(
      id: doc.id,
      habitId: data['habitId'] as String,
      ownerId: data['ownerId'] as String,
      date: (data['date'] as Timestamp).toDate(),
      completedAt: (data['completedAt'] as Timestamp).toDate(),
      value: data['value'] as int,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'habitId': habitId,
      'ownerId': ownerId,
      'date': Timestamp.fromDate(date),
      'completedAt': Timestamp.fromDate(completedAt),
      'value': value,
    };
  }
}
