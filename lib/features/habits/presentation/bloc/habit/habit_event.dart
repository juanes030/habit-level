part of 'habit_bloc.dart';

sealed class HabitEvent extends Equatable {
  const HabitEvent();

  @override
  List<Object> get props => [];
}

class HabitLoadRequested extends HabitEvent {
  final String ownerId;

  const HabitLoadRequested(this.ownerId);

  @override
  List<Object> get props => [ownerId];
}

class HabitCreateRequested extends HabitEvent {
  final Habit habit;

  const HabitCreateRequested(this.habit);

  @override
  List<Object> get props => [habit];
}
