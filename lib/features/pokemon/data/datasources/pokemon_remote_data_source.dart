import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';

import '../../../../core/errors/exceptions.dart' as excp;
import '../../../../core/util/gql_query.dart';
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

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final GraphQLClient client;

  PokemonRemoteDataSourceImpl({@required this.client});

  @override
  Future<List<PokemonModel>> getPokemonList(int first) async {
    try {
      final result = await client.query(QueryOptions(
        document: gql(GqlQuery.pokemonListQuery),
        variables: {"first": first},
      ));
      return result.data['pokemons']
          .map((e) => PokemonModel.fromJson(e))
          .cast<PokemonModel>()
          .toList();
    } on Exception {
      throw excp.ServerException();
    }
  }

  @override
  Future<PokemonModel> getPokemonDetail(String id) async {
    try {
      final result = await client.query(QueryOptions(
        document: gql(GqlQuery.pokemonDetailQuery),
        variables: {"id": id},
      ));
      return PokemonModel.fromJson(result.data['pokemon']);
    } on Exception {
      throw excp.ServerException();
    }
  }
}
