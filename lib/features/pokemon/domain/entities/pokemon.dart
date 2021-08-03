import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'pokemon_attack.dart';
import 'pokemon_dimension.dart';

class Pokemon extends Equatable {
  final String id;
  final String number;
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
    this.number,
    this.weight,
    this.height,
    this.classification,
    @required this.types,
    this.attacks,
    this.resistant,
    this.weaknesses,
    this.evolutions,
  }) : super();

  Map<String, dynamic> toJson({bool minimum = false}) {
    Map<String, dynamic> json = {
      'id': id,
      'name': name,
      'image': image,
      'types': types,
    };

    if (!minimum) {
      if (number != null) json['number'] = number;
      if (weight != null) json['weight'] = weight.toJson();
      if (height != null) json['height'] = height.toJson();
      if (classification != null) json['classification'] = classification;
      if (attacks != null) json['attacks'] = attacks.toJson();
      if (resistant != null) json['resistant'] = resistant;
      if (weaknesses != null) json['weaknesses'] = weaknesses;
      if (evolutions != null)
        json['evolutions'] = List<Map<String, dynamic>>.from(
            evolutions.map((p) => p.toJson(minimum: true)));
    }

    return json;
  }

  @override
  List<Object> get props => [id, name, image, types];
}
