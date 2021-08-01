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

  @override
  List<Object> get props => [fast, special];
}
