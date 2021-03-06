import 'package:meta/meta.dart';

import '../../domain/entities/pokemon.dart';
import 'pokemon_attack_model.dart';
import 'pokemon_dimension_model.dart';

class PokemonModel extends Pokemon {
  PokemonModel({
    @required String id,
    @required String name,
    @required String image,
    String number,
    PokemonDimensionModel weight,
    PokemonDimensionModel height,
    String classification,
    @required List<String> types,
    PokemonAttackModel attacks,
    List<String> resistant,
    List<String> weaknesses,
    List<Pokemon> evolutions,
  }) : super(
          id: id,
          number: number,
          name: name,
          image: image,
          weight: weight,
          height: height,
          classification: classification,
          types: types,
          attacks: attacks,
          resistant: resistant,
          weaknesses: weaknesses,
          evolutions: evolutions,
        );

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json['id'],
      number: json['number'] != null ? json['number'] : null,
      name: json['name'],
      image: json['image'],
      weight: json['weight'] != null
          ? PokemonDimensionModel.fromJson(json['weight'])
          : null,
      height: json['height'] != null
          ? PokemonDimensionModel.fromJson(json['height'])
          : null,
      classification: json['classification'] ?? null,
      types: List<String>.from(json['types']),
      attacks: json['attacks'] != null
          ? PokemonAttackModel.fromJson(json['attacks'])
          : null,
      resistant: json['resistant'] != null
          ? List<String>.from(json['resistant'])
          : null,
      weaknesses: json['weaknesses'] != null
          ? List<String>.from(json['weaknesses'])
          : null,
      evolutions: json['evolutions'] != null
          ? List<PokemonModel>.from(
              json['evolutions'].map((p) => PokemonModel.fromJson(p)),
            )
          : null,
    );
  }
}
