part of 'habit_completion_bloc.dart';

sealed class HabitCompletionEvent extends Equatable {
  const HabitCompletionEvent();

  @override
  List<Object> get props => [];
}

class HabitCompletionCreateRequested extends HabitCompletionEvent {
  final Habit habit;
  final String ownerId;

  const HabitCompletionCreateRequested({
    required this.habit,
    required this.ownerId,
  });

  @override
  List<Object> get props => [habit, ownerId];
}

class HabitCompletionsLoadRequested extends HabitCompletionEvent {
  final String habitId;
  final String ownerId;

  const HabitCompletionsLoadRequested({
    required this.habitId,
    required this.ownerId,
  });

  @override
  List<Object> get props => [habitId, ownerId];
}

class TodayHabitCompletionsLoadRequested extends HabitCompletionEvent {
  final String ownerId;

  const TodayHabitCompletionsLoadRequested(this.ownerId);

  @override
  List<Object> get props => [ownerId];
}
