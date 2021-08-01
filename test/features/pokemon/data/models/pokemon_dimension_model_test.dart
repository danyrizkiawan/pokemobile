import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pokemobile/features/pokemon/data/models/pokemon_dimension_model.dart';
import 'package:pokemobile/features/pokemon/domain/entities/pokemon_dimension.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tPokemonDimensionModel =
      PokemonDimensionModel(minimum: "6.04kg", maximum: "7.76kg");

  test(
    'should be a subclass of PokemonDimension entity',
    () {
      expect(tPokemonDimensionModel, isA<PokemonDimension>());
    },
  );

  group('fromJson', () {
    test('should return a valid model when the Json minimum is an String',
        () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('pokemon_dimension.json'));
      // act
      final result = PokemonDimensionModel.fromJson(jsonMap);
      // assert
      expect(result, tPokemonDimensionModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // act
      final result = tPokemonDimensionModel.toJson();
      // assert
      final expectedMap = {
        "minimum": "6.04kg",
        "maximum": "7.76kg",
      };
      expect(result, expectedMap);
    });
  });
}
