import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/habit_completion.dart';
import '../../../domain/exceptions/habit_completion_exceptions.dart';
import '../../../domain/usecases/create_habit_completion.dart';
import '../../../domain/usecases/get_habit_completions.dart';
import '../../../domain/usecases/get_today_habit_completions.dart';

part 'habit_completion_event.dart';
part 'habit_completion_state.dart';

@injectable
class HabitCompletionBloc
    extends Bloc<HabitCompletionEvent, HabitCompletionState> {
  final CreateHabitCompletion _createHabitCompletion;
  final GetHabitCompletions _getHabitCompletions;
  final GetTodayHabitCompletions _getTodayHabitCompletions;

  HabitCompletionBloc(
    this._createHabitCompletion,
    this._getHabitCompletions,
    this._getTodayHabitCompletions,
  ) : super(const HabitCompletionInitial()) {
    on<HabitCompletionCreateRequested>(_onHabitCompletionCreateRequested);

    on<HabitCompletionsLoadRequested>(_onHabitCompletionsLoadRequested);

    on<TodayHabitCompletionsLoadRequested>(
      _onTodayHabitCompletionsLoadRequested,
    );
  }

  Future<void> _onHabitCompletionCreateRequested(
    HabitCompletionCreateRequested event,
    Emitter<HabitCompletionState> emit,
  ) async {
    emit(const HabitCompletionLoading());

  try {
      final completion = await _createHabitCompletion(
        event.completion,
        frequency: event.frequency,
      );

      emit(HabitCompletionCreated(completion));

      final completions = await _getTodayHabitCompletions(
        event.completion.ownerId,
      );

      emit(TodayHabitCompletionsLoaded(completions));
    } on HabitAlreadyCompletedException {
      emit(const HabitCompletionError('Este hábito ya fue completado hoy.'));
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

  Future<void> _onTodayHabitCompletionsLoadRequested(
    TodayHabitCompletionsLoadRequested event,
    Emitter<HabitCompletionState> emit,
  ) async {
    emit(const HabitCompletionLoading());

    try {
      final completions = await _getTodayHabitCompletions(event.ownerId);

      emit(TodayHabitCompletionsLoaded(completions));
    } catch (e) {
      emit(
        const HabitCompletionError(
          'No se pudieron cargar las completaciones de hoy.',
        ),
      );
    }
  }
}
