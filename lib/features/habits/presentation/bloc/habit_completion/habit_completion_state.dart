part of 'habit_completion_bloc.dart';

sealed class HabitCompletionState extends Equatable {
  const HabitCompletionState();

  @override
  List<Object> get props => [];
}

class HabitCompletionInitial extends HabitCompletionState {
  const HabitCompletionInitial();
}

class HabitCompletionLoading extends HabitCompletionState {
  const HabitCompletionLoading();
}

class HabitCompletionLoaded extends HabitCompletionState {
  final List<HabitCompletion> completions;

  const HabitCompletionLoaded(this.completions);

  @override
  List<Object> get props => [completions];
}

class TodayHabitCompletionsLoaded extends HabitCompletionState {
  final List<HabitCompletion> completions;

  const TodayHabitCompletionsLoaded(this.completions);

  @override
  List<Object> get props => [completions];
}

class HabitCompletionCreated extends HabitCompletionState {
  final HabitCompletion completion;

  const HabitCompletionCreated(this.completion);

  @override
  List<Object> get props => [completion];
}

class HabitCompletionError extends HabitCompletionState {
  final String message;

  const HabitCompletionError(this.message);

  @override
  List<Object> get props => [message];
}
