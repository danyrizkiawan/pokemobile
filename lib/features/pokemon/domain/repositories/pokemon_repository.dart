import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/pokemon.dart';

abstract class PokemonRepository {
  Future<Either<Failure, List<Pokemon>>> getPokemonList(int first);
  Future<Either<Failure, Pokemon>> getPokemonDetail(String id);
}
