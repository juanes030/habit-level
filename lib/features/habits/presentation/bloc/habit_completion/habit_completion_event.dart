part of 'habit_completion_bloc.dart';

sealed class HabitCompletionEvent extends Equatable {
  const HabitCompletionEvent();

  @override
  List<Object> get props => [];
}

class HabitCompletionCreateRequested extends HabitCompletionEvent {
  final HabitCompletion completion;

  const HabitCompletionCreateRequested(this.completion);

  @override
  List<Object> get props => [completion];
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
