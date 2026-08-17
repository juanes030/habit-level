import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:habit_level/features/habits/domain/entities/habit.dart';
import 'package:habit_level/features/habits/domain/usecases/create_habit.dart';
import 'package:habit_level/features/habits/domain/usecases/get_habits.dart';
import 'package:injectable/injectable.dart';

part 'habit_event.dart';
part 'habit_state.dart';

@injectable
class HabitBloc extends Bloc<HabitEvent, HabitState> {
  final GetHabits _getHabits;
  final CreateHabit _createHabit;

  HabitBloc(this._getHabits, this._createHabit) : super(const HabitInitial()) {
    on<HabitLoadRequested>(_onHabitLoadRequested);
    on<HabitCreateRequested>(_onHabitCreateRequested);
  }

  Future<void> _onHabitLoadRequested(
    HabitLoadRequested event,
    Emitter<HabitState> emit,
  ) async {
    emit(const HabitLoading());

    try {
      final habits = await _getHabits(event.ownerId);

      emit(HabitLoaded(habits));
    } catch (e) {
      emit(const HabitError('No se pudieron cargar los hábitos.'));
    }
  }

  Future<void> _onHabitCreateRequested(
    HabitCreateRequested event,
    Emitter<HabitState> emit,
  ) async {
    emit(const HabitLoading());

    try {
      await _createHabit(event.habit);

      final habits = await _getHabits(event.habit.ownerId);

      emit(HabitLoaded(habits));
    } catch (e) {
      emit(const HabitError('No se pudo crear el hábito.'));
    }
  }
}
