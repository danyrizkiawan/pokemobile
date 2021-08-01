import 'package:meta/meta.dart';

import '../../domain/entities/pokemon_dimension.dart';

class PokemonDimensionModel extends PokemonDimension {
  PokemonDimensionModel({
    @required String minimum,
    @required String maximum,
  }) : super(minimum: minimum, maximum: maximum);

  factory PokemonDimensionModel.fromJson(Map<String, dynamic> json) {
    return PokemonDimensionModel(
      minimum: json['minimum'],
      maximum: json['maximum'],
    );
  }
}
