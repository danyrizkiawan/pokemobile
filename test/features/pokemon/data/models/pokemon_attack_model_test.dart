import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pokemobile/features/pokemon/data/models/attack_model.dart';
import 'package:pokemobile/features/pokemon/data/models/pokemon_attack_model.dart';
import 'package:pokemobile/features/pokemon/domain/entities/pokemon_attack.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tPokemonAttackModel = PokemonAttackModel(
    fast: [
      AttackModel(name: "Tackle", type: "Normal", damage: 12),
      AttackModel(name: "Vine Whip", type: "Grass", damage: 7),
    ],
    special: [
      AttackModel(name: "Power Whip", type: "Grass", damage: 70),
      AttackModel(name: "Seed Bomb", type: "Grass", damage: 40),
      AttackModel(name: "Sludge Bomb", type: "Poison", damage: 55),
    ],
  );
  final tPokemonAttackModelEmptyFast = PokemonAttackModel(
    fast: [],
    special: [
      AttackModel(name: "Power Whip", type: "Grass", damage: 70),
      AttackModel(name: "Seed Bomb", type: "Grass", damage: 40),
      AttackModel(name: "Sludge Bomb", type: "Poison", damage: 55),
    ],
  );
  final tPokemonAttackModelEmptySpecial = PokemonAttackModel(
    fast: [
      AttackModel(name: "Tackle", type: "Normal", damage: 12),
      AttackModel(name: "Vine Whip", type: "Grass", damage: 7),
    ],
    special: [],
  );

  test(
    'should be a subclass of PokemonAttack entity',
    () {
      expect(tPokemonAttackModel, isA<PokemonAttack>());
    },
  );

  group('fromJson', () {
    test(
        'should return a valid model when the Json fast and special are not empty list',
        () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('pokemon_attack.json'));
      // act
      final result = PokemonAttackModel.fromJson(jsonMap);
      // assert
      expect(result, tPokemonAttackModel);
    });

    test('should return a valid model when the Json fast is an empty list',
        () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('pokemon_attack_empty_fast.json'));
      // act
      final result = PokemonAttackModel.fromJson(jsonMap);
      // assert
      expect(result, tPokemonAttackModelEmptyFast);
    });

    test('should return a valid model when the Json special is an empty list',
        () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('pokemon_attack_empty_special.json'));
      // act
      final result = PokemonAttackModel.fromJson(jsonMap);
      // assert
      expect(result, tPokemonAttackModelEmptySpecial);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // act
      final result = tPokemonAttackModel.toJson();
      // assert
      final expectedMap = {
        "fast": [
          {"name": "Tackle", "type": "Normal", "damage": 12},
          {"name": "Vine Whip", "type": "Grass", "damage": 7}
        ],
        "special": [
          {"name": "Power Whip", "type": "Grass", "damage": 70},
          {"name": "Seed Bomb", "type": "Grass", "damage": 40},
          {"name": "Sludge Bomb", "type": "Poison", "damage": 55}
        ]
      };
      expect(result, expectedMap);
    });
  });
}
