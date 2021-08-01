import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/pokemon_model.dart';

abstract class PokemonLocalDataSource {
  PokemonLocalDataSource(sharmockSharedPreferences);

  /// Gets the cached [PokemonModel] which was gotten the last time
  /// the user had an internet connection
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<List<PokemonModel>> getLastPokemonList();

  Future<PokemonModel> getPokemonDetail(String id);

  Future<void> cachePokemonList(List<PokemonModel> pokemonListToCache);

  Future<void> cachePokemonDetail(PokemonModel pokemonDetailToCache);
}

const CACHED_POKEMON_LIST = 'CACHED_POKEMON_LIST';

class PokemonLocalDataSourceImpl implements PokemonLocalDataSource {
  final SharedPreferences sharedPreferences;

  PokemonLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<List<PokemonModel>> getLastPokemonList() {
    final jsonString = sharedPreferences.getString(CACHED_POKEMON_LIST);
    if (jsonString != null) {
      return Future.value(List<PokemonModel>.from(
          json.decode(jsonString).map((p) => PokemonModel.fromJson(p))));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cachePokemonList(List<PokemonModel> pokemonListToCache) {
    final pokemonListJson = List<Map<String, dynamic>>.from(
      pokemonListToCache.map((p) => p.toJson()),
    );
    return sharedPreferences.setString(
      CACHED_POKEMON_LIST,
      json.encode(pokemonListJson),
    );
  }

  @override
  Future<PokemonModel> getPokemonDetail(String id) {
    final jsonString = sharedPreferences.getString(id);
    if (jsonString != null) {
      return Future.value(PokemonModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cachePokemonDetail(PokemonModel pokemonDetailToCache) {
    sharedPreferences.setString(
      pokemonDetailToCache.id,
      json.encode(pokemonDetailToCache.toJson()),
    );
    return null;
  }
}
