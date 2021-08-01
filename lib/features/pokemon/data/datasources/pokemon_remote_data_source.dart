import '../models/pokemon_model.dart';

abstract class PokemonRemoteDataSource {
  /// Calls the graphql pokemon list query
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<PokemonModel>> getPokemonList(int first);

  /// Calls the graphql pokemon detail query
  ///
  /// Throws a [ServerException] for all error codes.
  Future<PokemonModel> getPokemonDetail(String id);
}
