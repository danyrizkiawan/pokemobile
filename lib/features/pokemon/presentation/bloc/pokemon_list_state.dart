part of 'pokemon_list_bloc.dart';

abstract class PokemonListState extends Equatable {
  final List<Pokemon> pokemons;
  final String message;

  PokemonListState({
    this.pokemons,
    this.message,
  }) : super();

  @override
  List<Object> get props => [pokemons, message];
}

class PokemonListInitial extends PokemonListState {}

class PokemonListNormal extends PokemonListState {}

class PokemonListFiltered extends PokemonListState {}
