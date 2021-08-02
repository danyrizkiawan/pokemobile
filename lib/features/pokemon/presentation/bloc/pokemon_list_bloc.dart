import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/usecases/get_pokemon_list.dart';

part 'pokemon_list_event.dart';
part 'pokemon_list_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class PokemonListBloc extends Bloc<PokemonListEvent, PokemonListState> {
  PokemonListBloc({@required GetPokemonList pokemonList})
      : assert(pokemonList != null),
        _getPokemonList = pokemonList,
        super(PokemonListInitial());

  final GetPokemonList _getPokemonList;

  @override
  Stream<PokemonListState> mapEventToState(
    PokemonListEvent event,
  ) async* {
    if (event is GetPokemons) {
      yield PokemonListLoading();
      final pokemons = await _getPokemonList(
        Params(first: event.first),
      );
      yield pokemons.fold(
        (failure) => PokemonListError(
          message: _mapFailureToMessage(failure),
        ),
        (data) => PokemonListLoaded(pokemons: data),
      );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    // Instead of a regular 'if (failure is ServerFailure)...'
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }

  Future<List<Pokemon>> getPokemonsInPage(int offset) async {
    offset = offset + 10;
    final either = await _getPokemonList(Params(first: offset));
    return either.fold(
      (l) => throw _getFailureAndThrowExpection(l),
      (r) => r.length < offset ? [] : r.getRange(offset - 10, offset).toList(),
    );
  }

  Exception _getFailureAndThrowExpection(Failure l) {
    if (l is ServerFailure) {
      return ServerException();
    } else if (l is CacheFailure) {
      return CacheException();
    } else {
      return UnknownException();
    }
  }
}
