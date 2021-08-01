import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/pokemon.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemonList implements UseCase<List<Pokemon>, Params> {
  final PokemonRepository repository;

  GetPokemonList(this.repository);

  Future<Either<Failure, List<Pokemon>>> call(Params params) async {
    return await repository.getPokemonList(params.first);
  }
}

class Params extends Equatable {
  final int first;

  Params({@required this.first}) : super();

  @override
  List<Object> get props => [first];
}
