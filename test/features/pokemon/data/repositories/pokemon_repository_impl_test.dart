import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemobile/core/errors/exceptions.dart';
import 'package:pokemobile/core/errors/failures.dart';
import 'package:pokemobile/core/network/network_info.dart';
import 'package:pokemobile/features/pokemon/data/datasources/pokemon_local_data_source.dart';
import 'package:pokemobile/features/pokemon/data/datasources/pokemon_remote_data_source.dart';
import 'package:pokemobile/features/pokemon/data/models/attack_model.dart';
import 'package:pokemobile/features/pokemon/data/models/pokemon_attack_model.dart';
import 'package:pokemobile/features/pokemon/data/models/pokemon_dimension_model.dart';
import 'package:pokemobile/features/pokemon/data/models/pokemon_model.dart';
import 'package:pokemobile/features/pokemon/data/repositories/pokemon_repository_impl.dart';

class MockRemoteDataSource extends Mock implements PokemonRemoteDataSource {}

class MockLocalDataSource extends Mock implements PokemonLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  PokemonRepositoryImpl repositoryImpl;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = PokemonRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getPokemonList', () {
    final tFirst = 1;
    final tPokemonList = [
      PokemonModel(
        id: "id",
        name: "Bulbasaur",
        image: "https://img.pokemondb.net/artwork/bulbasaur.jpg",
        types: ["Grass", "Poison"],
      ),
    ];

    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repositoryImpl.getPokemonList(tFirst);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getPokemonList(any))
            .thenAnswer((_) async => tPokemonList);
        // act
        final result = await repositoryImpl.getPokemonList(tFirst);
        // assert
        verify(mockRemoteDataSource.getPokemonList(tFirst));
        expect(result, equals(Right(tPokemonList)));
      });

      test(
          'should cache the data locally when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getPokemonList(any))
            .thenAnswer((_) async => tPokemonList);
        // act
        await repositoryImpl.getPokemonList(tFirst);
        // assert
        verify(mockRemoteDataSource.getPokemonList(tFirst));
        verify(mockLocalDataSource.cachePokemonList(tPokemonList));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getPokemonList(any))
            .thenThrow(ServerException());
        // act
        final result = await repositoryImpl.getPokemonList(tFirst);
        // assert
        verify(mockRemoteDataSource.getPokemonList(tFirst));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
          'should return last locally cached data when the cached data is present',
          () async {
        // arrange
        when(mockLocalDataSource.getLastPokemonList())
            .thenAnswer((_) async => tPokemonList);
        // act
        final result = await repositoryImpl.getPokemonList(tFirst);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastPokemonList());
        expect(result, equals(Right(tPokemonList)));
      });

      test('should return CacheFailure when there is no cached data present',
          () async {
        // arrange
        when(mockLocalDataSource.getLastPokemonList())
            .thenThrow(CacheException());
        // act
        final result = await repositoryImpl.getPokemonList(tFirst);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastPokemonList());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
  group('getPokemonDetail', () {
    final tPokemonID = "UG9rZW1vbjowMDE=";
    final tPokemonDetail = PokemonModel(
      id: "id",
      number: "001",
      name: "Bulbasaur",
      image: "https://img.pokemondb.net/artwork/bulbasaur.jpg",
      weight: PokemonDimensionModel(minimum: "6.04kg", maximum: "7.76kg"),
      height: PokemonDimensionModel(minimum: "0.61m", maximum: "0.79m"),
      classification: "Seed Pokémon",
      types: [
        "Grass",
        "Poison",
      ],
      attacks: PokemonAttackModel(
        fast: [
          AttackModel(name: "Tackle", type: "Normal", damage: 12),
          AttackModel(name: "Vine Whip", type: "Grass", damage: 7),
        ],
        special: [
          AttackModel(name: "Power Whip", type: "Grass", damage: 70),
          AttackModel(name: "Seed Bomb", type: "Grass", damage: 40),
          AttackModel(name: "Sludge Bomb", type: "Poison", damage: 55),
        ],
      ),
      resistant: ["Water", "Electric", "Grass", "Fighting", "Fairy"],
      weaknesses: ["Fire", "Ice", "Flying", "Psychic"],
      evolutions: [
        PokemonModel(
          id: "UG9rZW1vbjowMDI=",
          name: "Ivysaur",
          image: "https://img.pokemondb.net/artwork/ivysaur.jpg",
          types: ["Grass", "Poison"],
        ),
        PokemonModel(
          id: "UG9rZW1vbjowMDM=",
          name: "Venusaur",
          image: "https://img.pokemondb.net/artwork/venusaur.jpg",
          types: ["Grass", "Poison"],
        ),
      ],
    );

    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repositoryImpl.getPokemonDetail(tPokemonID);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getPokemonDetail(any))
            .thenAnswer((_) async => tPokemonDetail);
        // act
        final result = await repositoryImpl.getPokemonDetail(tPokemonID);
        // assert
        verify(mockRemoteDataSource.getPokemonDetail(tPokemonID));
        expect(result, equals(Right(tPokemonDetail)));
      });

      test(
          'should cache the data locally when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getPokemonDetail(any))
            .thenAnswer((_) async => tPokemonDetail);
        // act
        await repositoryImpl.getPokemonDetail(tPokemonID);
        // assert
        verify(mockRemoteDataSource.getPokemonDetail(tPokemonID));
        verify(mockLocalDataSource.cachePokemonDetail(tPokemonDetail));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getPokemonDetail(any))
            .thenThrow(ServerException());
        // act
        final result = await repositoryImpl.getPokemonDetail(tPokemonID);
        // assert
        verify(mockRemoteDataSource.getPokemonDetail(tPokemonID));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
          'should return last locally cached data when the cached data is present',
          () async {
        // arrange
        when(mockLocalDataSource.getPokemonDetail(any))
            .thenAnswer((_) async => tPokemonDetail);
        // act
        final result = await repositoryImpl.getPokemonDetail(tPokemonID);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getPokemonDetail(tPokemonID));
        expect(result, equals(Right(tPokemonDetail)));
      });

      test('should return CacheFailure when there is no cached data present',
          () async {
        // arrange
        when(mockLocalDataSource.getPokemonDetail(any))
            .thenThrow(CacheException());
        // act
        final result = await repositoryImpl.getPokemonDetail(tPokemonID);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getPokemonDetail(tPokemonID));
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}
