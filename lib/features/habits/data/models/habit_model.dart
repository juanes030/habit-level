import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/habit.dart';

class HabitModel extends Habit {
  const HabitModel({
    required super.id,
    required super.ownerId,
    required super.title,
    required super.description,
    required super.frequency,
    required super.target,
    required super.unit,
    required super.isActive,
    required super.createdAt,
    required super.updatedAt,
  });

  factory HabitModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data()!;

    return HabitModel(
      id: document.id,
      ownerId: data['ownerId'] as String,
      title: data['title'] as String,
      description: data['description'] as String,
      frequency: data['frequency'] as String,
      target: data['target'] as int,
      unit: data['unit'] as String,
      isActive: data['isActive'] as bool,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'ownerId': ownerId,
      'title': title,
      'description': description,
      'frequency': frequency,
      'target': target,
      'unit': unit,
      'isActive': isActive,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  factory HabitModel.fromEntity(Habit habit) {
    return HabitModel(
      id: habit.id,
      ownerId: habit.ownerId,
      title: habit.title,
      description: habit.description,
      frequency: habit.frequency,
      target: habit.target,
      unit: habit.unit,
      isActive: habit.isActive,
      createdAt: habit.createdAt,
      updatedAt: habit.updatedAt,
    );
  }
}
