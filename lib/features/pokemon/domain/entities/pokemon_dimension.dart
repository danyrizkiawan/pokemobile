import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class PokemonDimension extends Equatable {
  final String minimum;
  final String maximum;

  PokemonDimension({
    @required this.minimum,
    @required this.maximum,
  }) : super();

  @override
  List<Object> get props => [minimum, maximum];
}
