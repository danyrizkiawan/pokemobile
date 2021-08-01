import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'pokemon_attack.dart';
import 'pokemon_dimension.dart';

class Pokemon extends Equatable {
  final String id;
  final String name;
  final String image;
  final PokemonDimension weight;
  final PokemonDimension height;
  final String classification;
  final List<String> types;
  final PokemonAttack attacks;
  final List<String> resistant;
  final List<String> weaknesses;
  final List<Pokemon> evolutions;

  Pokemon({
    @required this.id,
    @required this.name,
    @required this.image,
    this.weight,
    this.height,
    this.classification,
    this.types,
    this.attacks,
    this.resistant,
    this.weaknesses,
    this.evolutions,
  }) : super();

  @override
  List<Object> get props => [id, name, image];
}
