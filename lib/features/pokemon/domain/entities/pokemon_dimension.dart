import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class PokemonDimension extends Equatable {
  final String minimum;
  final String maximum;

  PokemonDimension({
    @required this.minimum,
    @required this.maximum,
  }) : super();

  Map<String, dynamic> toJson() {
    return {
      'minimum': minimum,
      'maximum': maximum,
    };
  }

  @override
  List<Object> get props => [minimum, maximum];
}
