import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'attack.dart';

class PokemonAttack extends Equatable {
  final List<Attack> fast;
  final List<Attack> special;

  PokemonAttack({
    @required this.fast,
    @required this.special,
  }) : super();

  Map<String, dynamic> toJson() {
    return {
      'fast': List<Map<String, dynamic>>.from(fast.map((a) => a.toJson())),
      'special':
          List<Map<String, dynamic>>.from(special.map((a) => a.toJson())),
    };
  }

  @override
  List<Object> get props => [fast, special];
}
