import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pokemobile/features/pokemon/data/models/attack_model.dart';
import 'package:pokemobile/features/pokemon/data/models/pokemon_attack_model.dart';
import 'package:pokemobile/features/pokemon/data/models/pokemon_dimension_model.dart';
import 'package:pokemobile/features/pokemon/data/models/pokemon_model.dart';
import 'package:pokemobile/features/pokemon/domain/entities/pokemon.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tPokemonModelMin = PokemonModel(
    id: "UG9rZW1vbjowMDE=",
    name: "Bulbasaur",
    image: "https://img.pokemondb.net/artwork/bulbasaur.jpg",
    types: ["Grass", "Poison"],
  );

  final tPokemonModel = PokemonModel(
    id: "UG9rZW1vbjowMDE=",
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

  test(
    'should be a subclass of Pokemon entity',
    () {
      expect(tPokemonModel, isA<Pokemon>());
    },
  );

  group('fromJson', () {
    test('should return a valid model when the Json has complete data',
        () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('pokemon.json'));
      // act
      final result = PokemonModel.fromJson(jsonMap);
      // assert
      expect(result, tPokemonModel);
    });
    test(
        'should return a valid model when the Json only contains mandatory fields',
        () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('pokemon_min.json'));
      // act
      final result = PokemonModel.fromJson(jsonMap);
      // assert
      expect(result, tPokemonModelMin);
    });
    test(
        'should return a valid model when the Json has complete data is in Grapql return format',
        () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('pokemon_graphql.json'));
      // act
      final result = PokemonModel.fromJson(jsonMap['data']['pokemon']);
      // assert
      expect(result, tPokemonModel);
    });
    test(
        'should return a valid model when the Json that only contains mandatory fields is in Grapql return format',
        () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('pokemon_graphql_min.json'));
      // act
      final result = PokemonModel.fromJson(jsonMap['data']['pokemon']);
      // assert
      expect(result, tPokemonModelMin);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper pokemon data',
        () async {
      // act
      print(tPokemonModel.weight);
      final result = tPokemonModel.toJson();
      // assert
      final expectedMap = {
        "id": "UG9rZW1vbjowMDE=",
        "number": "001",
        "name": "Bulbasaur",
        "image": "https://img.pokemondb.net/artwork/bulbasaur.jpg",
        "weight": {"minimum": "6.04kg", "maximum": "7.76kg"},
        "height": {"minimum": "0.61m", "maximum": "0.79m"},
        "classification": "Seed Pokémon",
        "types": ["Grass", "Poison"],
        "attacks": {
          "fast": [
            {"name": "Tackle", "type": "Normal", "damage": 12},
            {"name": "Vine Whip", "type": "Grass", "damage": 7}
          ],
          "special": [
            {"name": "Power Whip", "type": "Grass", "damage": 70},
            {"name": "Seed Bomb", "type": "Grass", "damage": 40},
            {"name": "Sludge Bomb", "type": "Poison", "damage": 55}
          ]
        },
        "resistant": ["Water", "Electric", "Grass", "Fighting", "Fairy"],
        "weaknesses": ["Fire", "Ice", "Flying", "Psychic"],
        "evolutions": [
          {
            "id": "UG9rZW1vbjowMDI=",
            "image": "https://img.pokemondb.net/artwork/ivysaur.jpg",
            "name": "Ivysaur",
            "types": ["Grass", "Poison"],
          },
          {
            "id": "UG9rZW1vbjowMDM=",
            "image": "https://img.pokemondb.net/artwork/venusaur.jpg",
            "name": "Venusaur",
            "types": ["Grass", "Poison"],
          }
        ]
      };
      expect(result, expectedMap);
    });
    test('should return a JSON map containing the proper pokemon minimum data',
        () async {
      // act
      final result = tPokemonModel.toJson(minimum: true);
      // assert
      final expectedMap = {
        "id": "UG9rZW1vbjowMDE=",
        "name": "Bulbasaur",
        "image": "https://img.pokemondb.net/artwork/bulbasaur.jpg",
        "types": ["Grass", "Poison"],
      };
      expect(result, expectedMap);
    });
  });
}
