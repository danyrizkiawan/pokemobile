part of 'pokemon_detail_bloc.dart';

abstract class PokemonDetailState extends Equatable {
  PokemonDetailState([List props = const <dynamic>[]]) : super();

  @override
  List<Object> get props => [];
}

class PokemonDetailInitial extends PokemonDetailState {}

class PokemonDetailLoading extends PokemonDetailState {}

class PokemonDetailLoaded extends PokemonDetailState {
  final Pokemon pokemon;

  PokemonDetailLoaded({@required this.pokemon}) : super([pokemon]);
}

class PokemonDetailError extends PokemonDetailState {
  final String message;

  PokemonDetailError({@required this.message}) : super([message]);
}
