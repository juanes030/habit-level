import 'package:equatable/equatable.dart';

class HabitCompletion extends Equatable {
  final String id;
  final String habitId;
  final String ownerId;
  final DateTime date;
  final DateTime completedAt;
  final int value;

  const HabitCompletion({
    required this.id,
    required this.habitId,
    required this.ownerId,
    required this.date,
    required this.completedAt,
    required this.value,
  });

  @override
  List<Object?> get props => [id, habitId, ownerId, date, completedAt, value];
}
