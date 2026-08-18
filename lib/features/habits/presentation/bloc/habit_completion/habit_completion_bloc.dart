import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:habit_level/features/habits/domain/entities/habit_completion.dart';
import 'package:habit_level/features/habits/domain/usecases/create_habit_completion.dart';
import 'package:habit_level/features/habits/domain/usecases/get_habit_completions.dart';
import 'package:injectable/injectable.dart';

part 'habit_completion_event.dart';
part 'habit_completion_state.dart';

@injectable
class HabitCompletionBloc
    extends Bloc<HabitCompletionEvent, HabitCompletionState> {
  final CreateHabitCompletion _createHabitCompletion;
  final GetHabitCompletions _getHabitCompletions;

  HabitCompletionBloc(this._createHabitCompletion, this._getHabitCompletions)
    : super(const HabitCompletionInitial()) {
    on<HabitCompletionCreateRequested>(_onHabitCompletionCreateRequested);

    on<HabitCompletionsLoadRequested>(_onHabitCompletionsLoadRequested);
  }

  Future<void> _onHabitCompletionCreateRequested(
    HabitCompletionCreateRequested event,
    Emitter<HabitCompletionState> emit,
  ) async {
    emit(const HabitCompletionLoading());

    try {
      final completion = await _createHabitCompletion(event.completion);

      emit(HabitCompletionCreated(completion));
    } catch (e) {
      emit(const HabitCompletionError('No se pudo registrar la completación.'));
    }
  }

  Future<void> _onHabitCompletionsLoadRequested(
    HabitCompletionsLoadRequested event,
    Emitter<HabitCompletionState> emit,
  ) async {
    emit(const HabitCompletionLoading());

    try {
      final completions = await _getHabitCompletions(
        event.habitId,
        event.ownerId,
      );

      emit(HabitCompletionLoaded(completions));
    } catch (e) {
      emit(
        const HabitCompletionError('No se pudieron cargar las completaciones.'),
      );
    }
  }
}
