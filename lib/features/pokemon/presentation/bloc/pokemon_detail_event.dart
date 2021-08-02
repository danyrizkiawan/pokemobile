part of 'pokemon_detail_bloc.dart';

abstract class PokemonDetailEvent extends Equatable {
  PokemonDetailEvent([List props = const <dynamic>[]]) : super();

  @override
  List<Object> get props => props;
}

class GetPokemon extends PokemonDetailEvent {
  final String id;

  GetPokemon({@required this.id}) : super([id]);
}
