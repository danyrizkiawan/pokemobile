part of 'pokemon_list_bloc.dart';

@immutable
abstract class PokemonListState extends Equatable {
  PokemonListState([List props = const <dynamic>[]]) : super();

  @override
  List<Object> get props => props;
}

class PokemonListInitial extends PokemonListState {}

class PokemonListLoading extends PokemonListState {}

class PokemonListLoaded extends PokemonListState {
  final List<Pokemon> pokemons;

  PokemonListLoaded({@required this.pokemons}) : super([pokemons]);
}

class PokemonListError extends PokemonListState {
  final String message;

  PokemonListError({@required this.message}) : super([message]);
}
