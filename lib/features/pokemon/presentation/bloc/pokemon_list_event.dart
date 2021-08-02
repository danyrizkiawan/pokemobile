part of 'pokemon_list_bloc.dart';

abstract class PokemonListEvent extends Equatable {
  PokemonListEvent([List props = const <dynamic>[]]) : super();
  @override
  List<Object> get props => props;
}

class GetPokemons extends PokemonListEvent {
  final int first;

  GetPokemons(this.first) : super([first]);
}
