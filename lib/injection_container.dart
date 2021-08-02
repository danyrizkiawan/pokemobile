import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/pokemon/data/datasources/pokemon_local_data_source.dart';
import 'features/pokemon/data/datasources/pokemon_remote_data_source.dart';
import 'features/pokemon/data/repositories/pokemon_repository_impl.dart';
import 'features/pokemon/domain/repositories/pokemon_repository.dart';
import 'features/pokemon/domain/usecases/get_pokemon_detail.dart';
import 'features/pokemon/domain/usecases/get_pokemon_list.dart';
import 'features/pokemon/presentation/bloc/pokemon_detail_bloc.dart';
import 'features/pokemon/presentation/bloc/pokemon_list_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Pokemon
  // Bloc
  sl.registerFactory(
    () => PokemonListBloc(pokemonList: sl()),
  );
  sl.registerFactory(
    () => PokemonDetailBloc(pokemonDetail: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetPokemonList(sl()));
  sl.registerLazySingleton(() => GetPokemonDetail(sl()));

  // Repository
  sl.registerLazySingleton<PokemonRepository>(
    () => PokemonRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<PokemonRemoteDataSource>(
    () => PokemonRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<PokemonLocalDataSource>(
    () => PokemonLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => DataConnectionChecker());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  final HttpLink httpLink = HttpLink('https://graphql-pokemon2.vercel.app/');
  sl.registerLazySingleton(
    () => GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    ),
  );
}
