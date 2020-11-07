// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:http/http.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'core/utils/input_converter.dart';
import 'core/network/network_info.dart';
import 'features/number_trivia/presentation/blocs/number_trivia_bloc.dart';
import 'features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'injection.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

Future<GetIt> $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) async {
  final gh = GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.lazySingleton<Client>(() => registerModule.client);
  gh.lazySingleton<DataConnectionChecker>(
      () => registerModule.connectionChecker);
  gh.lazySingleton<InputConverter>(() => InputConverter());
  gh.lazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(get<DataConnectionChecker>()));
  gh.lazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(client: get<Client>()));
  final sharedPreferences = await registerModule.prefs;
  gh.lazySingleton<SharedPreferences>(() => sharedPreferences);
  gh.lazySingleton<NumberTriviaLocalDataSource>(() =>
      NumberTriviaLocalDataSourceImpl(
          sharedPreferences: get<SharedPreferences>()));
  gh.lazySingleton<NumberTriviaRepository>(() => NumberTriviaRepositoryImpl(
        remoteDataSource: get<NumberTriviaRemoteDataSource>(),
        localDataSource: get<NumberTriviaLocalDataSource>(),
        networkInfo: get<NetworkInfo>(),
      ));
  gh.lazySingleton<GetConcreteNumberTrivia>(
      () => GetConcreteNumberTrivia(get<NumberTriviaRepository>()));
  gh.lazySingleton<GetRandomNumberTrivia>(
      () => GetRandomNumberTrivia(get<NumberTriviaRepository>()));
  gh.factory<NumberTriviaBloc>(() => NumberTriviaBloc(
        concrete: get<GetConcreteNumberTrivia>(),
        random: get<GetRandomNumberTrivia>(),
        inputConverter: get<InputConverter>(),
      ));
  return get;
}

class _$RegisterModule extends RegisterModule {}
