// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:habit_level/core/di/injection.dart' as _i580;
import 'package:habit_level/features/auth/data/datasources/auth_remote_data_source.dart'
    as _i376;
import 'package:habit_level/features/auth/data/repositories/auth_repository_impl.dart'
    as _i240;
import 'package:habit_level/features/auth/domain/repositories/auth_repository.dart'
    as _i189;
import 'package:habit_level/features/auth/domain/usecases/get_auth_state.dart'
    as _i614;
import 'package:habit_level/features/auth/domain/usecases/send_password_reset_email.dart'
    as _i19;
import 'package:habit_level/features/auth/domain/usecases/sign_in.dart'
    as _i151;
import 'package:habit_level/features/auth/domain/usecases/sign_out.dart'
    as _i417;
import 'package:habit_level/features/auth/domain/usecases/sign_up.dart'
    as _i427;
import 'package:habit_level/features/auth/presentation/bloc/auth/auth_bloc.dart'
    as _i710;
import 'package:habit_level/features/habits/data/datasources/habit_completion_remote_data_source.dart'
    as _i949;
import 'package:habit_level/features/habits/data/datasources/habit_completion_remote_data_source_impl.dart'
    as _i877;
import 'package:habit_level/features/habits/data/datasources/habit_remote_data_source.dart'
    as _i573;
import 'package:habit_level/features/habits/data/datasources/habit_remote_data_source_impl.dart'
    as _i190;
import 'package:habit_level/features/habits/data/repositories/habit_completion_repository_impl.dart'
    as _i422;
import 'package:habit_level/features/habits/data/repositories/habit_repository_impl.dart'
    as _i567;
import 'package:habit_level/features/habits/domain/repositories/habit_completion_repository.dart'
    as _i530;
import 'package:habit_level/features/habits/domain/repositories/habit_repository.dart'
    as _i732;
import 'package:habit_level/features/habits/domain/usecases/create_habit.dart'
    as _i920;
import 'package:habit_level/features/habits/domain/usecases/create_habit_completion.dart'
    as _i1009;
import 'package:habit_level/features/habits/domain/usecases/get_habit_completions.dart'
    as _i846;
import 'package:habit_level/features/habits/domain/usecases/get_habits.dart'
    as _i16;
import 'package:habit_level/features/habits/domain/usecases/get_today_habit_completions.dart'
    as _i3;
import 'package:habit_level/features/habits/presentation/bloc/habit/habit_bloc.dart'
    as _i340;
import 'package:habit_level/features/habits/presentation/bloc/habit_completion/habit_completion_bloc.dart'
    as _i100;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final firebaseModule = _$FirebaseModule();
    gh.lazySingleton<_i59.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.lazySingleton<_i974.FirebaseFirestore>(() => firebaseModule.firestore);
    gh.lazySingleton<_i949.HabitCompletionRemoteDataSource>(
      () => _i877.HabitCompletionRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i573.HabitRemoteDataSource>(
      () => _i190.HabitRemoteDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i376.AuthRemoteDataSource>(
      () => _i376.AuthRemoteDataSourceImpl(gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i530.HabitCompletionRepository>(
      () => _i422.HabitCompletionRepositoryImpl(
        gh<_i949.HabitCompletionRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i732.HabitRepository>(
      () => _i567.HabitRepositoryImpl(gh<_i573.HabitRemoteDataSource>()),
    );
    gh.lazySingleton<_i189.AuthRepository>(
      () => _i240.AuthRepositoryImpl(gh<_i376.AuthRemoteDataSource>()),
    );
    gh.factory<_i920.CreateHabit>(
      () => _i920.CreateHabit(gh<_i732.HabitRepository>()),
    );
    gh.factory<_i16.GetHabits>(
      () => _i16.GetHabits(gh<_i732.HabitRepository>()),
    );
    gh.factory<_i614.GetAuthState>(
      () => _i614.GetAuthState(gh<_i189.AuthRepository>()),
    );
    gh.factory<_i19.SendPasswordResetEmail>(
      () => _i19.SendPasswordResetEmail(gh<_i189.AuthRepository>()),
    );
    gh.factory<_i151.SignIn>(() => _i151.SignIn(gh<_i189.AuthRepository>()));
    gh.factory<_i417.SignOut>(() => _i417.SignOut(gh<_i189.AuthRepository>()));
    gh.factory<_i427.SignUp>(() => _i427.SignUp(gh<_i189.AuthRepository>()));
    gh.factory<_i1009.CreateHabitCompletion>(
      () => _i1009.CreateHabitCompletion(gh<_i530.HabitCompletionRepository>()),
    );
    gh.factory<_i846.GetHabitCompletions>(
      () => _i846.GetHabitCompletions(gh<_i530.HabitCompletionRepository>()),
    );
    gh.factory<_i3.GetTodayHabitCompletions>(
      () => _i3.GetTodayHabitCompletions(gh<_i530.HabitCompletionRepository>()),
    );
    gh.lazySingleton<_i710.AuthBloc>(
      () => _i710.AuthBloc(
        gh<_i614.GetAuthState>(),
        gh<_i151.SignIn>(),
        gh<_i427.SignUp>(),
        gh<_i417.SignOut>(),
        gh<_i19.SendPasswordResetEmail>(),
      ),
    );
    gh.factory<_i340.HabitBloc>(
      () => _i340.HabitBloc(gh<_i16.GetHabits>(), gh<_i920.CreateHabit>()),
    );
    gh.factory<_i100.HabitCompletionBloc>(
      () => _i100.HabitCompletionBloc(
        gh<_i1009.CreateHabitCompletion>(),
        gh<_i846.GetHabitCompletions>(),
        gh<_i3.GetTodayHabitCompletions>(),
      ),
    );
    return this;
  }
}

class _$FirebaseModule extends _i580.FirebaseModule {}
