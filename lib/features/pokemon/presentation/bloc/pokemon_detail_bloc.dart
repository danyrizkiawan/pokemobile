import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/usecases/get_pokemon_detail.dart';

part 'pokemon_detail_event.dart';
part 'pokemon_detail_state.dart';

const String SERVER_FAILURE_MESSAGE =
    'Failed to fetch data from server. Please try again later.';
const String CACHE_FAILURE_MESSAGE =
    'No internet connection. Please turn on your Mobile Data or WiFi.';

class PokemonDetailBloc extends Bloc<PokemonDetailEvent, PokemonDetailState> {
  PokemonDetailBloc({@required GetPokemonDetail pokemonDetail})
      : assert(pokemonDetail != null),
        _getPokemonDetail = pokemonDetail,
        super(PokemonDetailInitial());

  final GetPokemonDetail _getPokemonDetail;

  @override
  Stream<PokemonDetailState> mapEventToState(
    PokemonDetailEvent event,
  ) async* {
    if (event is GetPokemon) {
      yield PokemonDetailLoading();
      final pokemon = await _getPokemonDetail(
        Params(id: event.id),
      );
      yield pokemon.fold(
        (failure) => PokemonDetailError(message: _mapFailureToMessage(failure)),
        (data) => PokemonDetailLoaded(pokemon: data),
      );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
