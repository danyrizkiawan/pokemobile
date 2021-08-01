import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pokemobile/features/pokemon/data/models/attack_model.dart';
import 'package:pokemobile/features/pokemon/domain/entities/attack.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tAttackModel = AttackModel(name: "Tackle", type: "Normal", damage: 12);

  test(
    'should be a subclass of Attack entity',
    () {
      expect(tAttackModel, isA<Attack>());
    },
  );

  group('fromJson', () {
    test('should return a valid model when the Json damage is an integer',
        () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('attack.json'));
      // act
      final result = AttackModel.fromJson(jsonMap);
      // assert
      expect(result, tAttackModel);
    });

    test(
        'should return a valid model when the Json damage is regarded as a double',
        () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('attack_double.json'));
      // act
      final result = AttackModel.fromJson(jsonMap);
      // assert
      expect(result, tAttackModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // act
      final result = tAttackModel.toJson();
      // assert
      final expectedMap = {
        "name": "Tackle",
        "type": "Normal",
        "damage": 12,
      };
      expect(result, expectedMap);
    });
  });
}
