part of 'habit_completion_bloc.dart';

sealed class HabitCompletionEvent extends Equatable {
  const HabitCompletionEvent();

  @override
  List<Object> get props => [];
}

class HabitCompletionCreateRequested extends HabitCompletionEvent {
  final HabitCompletion completion;
  final String frequency;

  const HabitCompletionCreateRequested({
    required this.completion,
    required this.frequency,
  });

  @override
  List<Object> get props => [completion, frequency];
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
