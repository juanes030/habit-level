import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../models/habit_completion_model.dart';
import 'habit_completion_remote_data_source.dart';

@LazySingleton(as: HabitCompletionRemoteDataSource)
class HabitCompletionRemoteDataSourceImpl
    implements HabitCompletionRemoteDataSource {
  final FirebaseFirestore firestore;

  HabitCompletionRemoteDataSourceImpl(this.firestore);

  CollectionReference<Map<String, dynamic>> get _completionsCollection =>
      firestore.collection('habit_completions');

  @override
  Future<HabitCompletionModel> createCompletion(
    HabitCompletionModel completion,
  ) async {
    final document = _completionsCollection.doc();

    await document.set(completion.toFirestore());

    final snapshot = await document.get();

    return HabitCompletionModel.fromFirestore(snapshot);
  }

  @override
  Future<List<HabitCompletionModel>> getCompletions(
    String habitId,
    String ownerId,
  ) async {
    final snapshot = await _completionsCollection
        .where('habitId', isEqualTo: habitId)
        .where('ownerId', isEqualTo: ownerId)
        .orderBy('date', descending: true)
        .get();

    return snapshot.docs.map(HabitCompletionModel.fromFirestore).toList();
  }
}
