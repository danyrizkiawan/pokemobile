part of 'pokemon_list_bloc.dart';

abstract class PokemonListEvent extends Equatable {
  PokemonListEvent() : super();
  @override
  List<Object> get props => props;
}

class GetAllPokemons extends PokemonListEvent {}

class FilterPokemons extends PokemonListEvent {}
