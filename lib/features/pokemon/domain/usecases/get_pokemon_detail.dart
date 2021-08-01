import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/pokemon.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemonDetail implements UseCase<Pokemon, Params> {
  final PokemonRepository repository;

  GetPokemonDetail(this.repository);

  Future<Either<Failure, Pokemon>> call(Params params) async {
    return await repository.getPokemonDetail(params.id);
  }
}

class Params extends Equatable {
  final String id;

  Params({@required this.id}) : super();

  @override
  List<Object> get props => [id];
}
