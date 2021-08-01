import 'package:meta/meta.dart';

import '../../domain/entities/pokemon_attack.dart';
import 'attack_model.dart';

class PokemonAttackModel extends PokemonAttack {
  PokemonAttackModel({
    @required List<AttackModel> fast,
    @required List<AttackModel> special,
  }) : super(fast: fast, special: special);

  factory PokemonAttackModel.fromJson(Map<String, dynamic> json) {
    return PokemonAttackModel(
      fast: List<AttackModel>.from(
          json['fast'].map((a) => AttackModel.fromJson(a))),
      special: List<AttackModel>.from(
          json['special'].map((a) => AttackModel.fromJson(a))),
    );
  }
}
