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
    if (event is FilterPokemons) {
      yield PokemonListFiltered();
    } else {
      yield PokemonListNormal();
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

  Future<List<Pokemon>> getFilteredPokemonsInPage(
    int offset,
    List<String> filtered, {
    int currentItemLength,
  }) async {
    int newOffset = offset + 20;
    if (currentItemLength == null) {
      currentItemLength = offset;
    }
    final either = await _getPokemonList(Params(first: newOffset));
    return either.fold(
      (l) => throw _getFailureAndThrowExpection(l),
      (r) {
        List<Pokemon> filteredList = [];
        r.forEach((pokemon) {
          pokemon.types.forEach((element) {
            if (filtered.contains(element)) {
              filteredList.add(pokemon);
              return;
            }
          });
        });
        if (offset > r.length) {
          return filteredList
              .getRange(currentItemLength <= 0 ? 0 : currentItemLength,
                  filteredList.length)
              .toList();
        }
        // print(
        //     "response: ${r.length} - offset: $offset - current $currentItemLength - filter: ${filteredList.length}");
        return filteredList.length - currentItemLength < 10
            ? getFilteredPokemonsInPage(newOffset, filtered,
                currentItemLength: currentItemLength)
            : filteredList
                .getRange(currentItemLength, currentItemLength + 10)
                .toList();
      },
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
