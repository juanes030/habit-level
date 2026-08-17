import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/habit.dart';
import '../models/habit_model.dart';
import 'habit_remote_data_source.dart';

@LazySingleton(as: HabitRemoteDataSource)
class HabitRemoteDataSourceImpl implements HabitRemoteDataSource {
  final FirebaseFirestore firestore;

  HabitRemoteDataSourceImpl(this.firestore);

  CollectionReference<Map<String, dynamic>> get _habitsCollection =>
      firestore.collection('habits');

@override
  Future<List<Habit>> getHabits(String ownerId) async {
    final snapshot = await _habitsCollection
        .where('ownerId', isEqualTo: ownerId)
        .get();

    return snapshot.docs.map(HabitModel.fromFirestore).toList();
  }

  @override
  Future<Habit> getHabit(String habitId) async {
    final document = await _habitsCollection.doc(habitId).get();

    if (!document.exists) {
      throw Exception('Habit not found');
    }

    return HabitModel.fromFirestore(document);
  }

  @override
  Future<Habit> createHabit(Habit habit) async {
    final document = _habitsCollection.doc();

    final now = DateTime.now();

    final habitToCreate = HabitModel(
      id: document.id,
      ownerId: habit.ownerId,
      title: habit.title,
      description: habit.description,
      frequency: habit.frequency,
      target: habit.target,
      unit: habit.unit,
      isActive: habit.isActive,
      createdAt: now,
      updatedAt: now,
    );

    await document.set(habitToCreate.toFirestore());

    return habitToCreate;
  }

  @override
  Future<Habit> updateHabit(Habit habit) async {
    final habitToUpdate = HabitModel(
      id: habit.id,
      ownerId: habit.ownerId,
      title: habit.title,
      description: habit.description,
      frequency: habit.frequency,
      target: habit.target,
      unit: habit.unit,
      isActive: habit.isActive,
      createdAt: habit.createdAt,
      updatedAt: DateTime.now(),
    );

    await _habitsCollection.doc(habit.id).update(habitToUpdate.toFirestore());

    return habitToUpdate;
  }

  @override
  Future<void> deleteHabit(String habitId) async {
    await _habitsCollection.doc(habitId).delete();
  }
}
