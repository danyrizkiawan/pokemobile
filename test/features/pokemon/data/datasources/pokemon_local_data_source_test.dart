import 'dart:convert';

import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemobile/core/errors/exceptions.dart';
import 'package:pokemobile/features/pokemon/data/datasources/pokemon_local_data_source.dart';
import 'package:pokemobile/features/pokemon/data/models/attack_model.dart';
import 'package:pokemobile/features/pokemon/data/models/pokemon_attack_model.dart';
import 'package:pokemobile/features/pokemon/data/models/pokemon_dimension_model.dart';
import 'package:pokemobile/features/pokemon/data/models/pokemon_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  PokemonLocalDataSourceImpl dataSourceImpl;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSourceImpl = PokemonLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getLastPokemonList', () {
    final tPokemonModelList = List<PokemonModel>.from(json
        .decode(fixture('pokemon_list_cached.json'))
        .map((p) => PokemonModel.fromJson(p)));

    test(
      'should return List of Pokemon from SharedPreferences when there is one in the cache',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('pokemon_list_cached.json'));
        // act
        final result = await dataSourceImpl.getLastPokemonList();
        // assert
        verify(mockSharedPreferences.getString('CACHED_POKEMON_LIST'));
        expect(result, equals(tPokemonModelList));
      },
    );

    test(
      'should throw a CacheException when there is not a cached pokemon list',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        // act
        final call = dataSourceImpl.getLastPokemonList;
        // assert
        expect(() => call(), throwsA(TypeMatcher<CacheException>()));
      },
    );
  });

  group('cachePokemonList', () {
    final tPokemenList = [
      PokemonModel(
        id: "id",
        name: "Bulbasaur",
        image: "https://img.pokemondb.net/artwork/bulbasaur.jpg",
      ),
    ];
    test(
      'should call SharedPreferences to cache the last pokemon list',
      () async {
        // act
        dataSourceImpl.cachePokemonList(tPokemenList);
        // assert
        final pokemonList = List<Map<String, dynamic>>.from(
          tPokemenList.map((p) => p.toJson()),
        );
        final expectedJsonString = json.encode(pokemonList);
        verify(mockSharedPreferences.setString(
          CACHED_POKEMON_LIST,
          expectedJsonString,
        ));
      },
    );
  });

  group('getPokemonDetail', () {
    final tPokemonID = "UG9rZW1vbjowMDE=";
    final tPokemonDetail = PokemonModel.fromJson(
      json.decode(fixture('pokemon_detail_cached.json')),
    );

    test(
      'should return Pokemon details from SharedPreferences when there is one in the cache',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('pokemon_detail_cached.json'));
        // act
        final result = await dataSourceImpl.getPokemonDetail(tPokemonID);
        // assert
        verify(mockSharedPreferences.getString(tPokemonID));
        expect(result, equals(tPokemonDetail));
      },
    );

    test(
      'should throw a CacheException when there is not a cached pokemon detail',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        // act
        final call = dataSourceImpl.getPokemonDetail;
        // assert
        expect(() => call(tPokemonID), throwsA(TypeMatcher<CacheException>()));
      },
    );
  });

  group('cachePokemonDetail', () {
    final tPokemonModel = PokemonModel(
      id: "UG9rZW1vbjowMDE=",
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
        ),
        PokemonModel(
          id: "UG9rZW1vbjowMDM=",
          name: "Venusaur",
          image: "https://img.pokemondb.net/artwork/venusaur.jpg",
        ),
      ],
    );

    test(
      'should call SharedPreferences to cache the pokemon detail',
      () async {
        // act
        dataSourceImpl.cachePokemonDetail(tPokemonModel);
        // assert
        final expectedJsonString = json.encode(tPokemonModel.toJson());
        verify(
          mockSharedPreferences.setString(tPokemonModel.id, expectedJsonString),
        );
      },
    );
  });
}
