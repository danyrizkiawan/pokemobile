import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../datasources/pokemon_local_data_source.dart';
import '../datasources/pokemon_remote_data_source.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource remoteDataSource;
  final PokemonLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PokemonRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Pokemon>>> getPokemonList(int first) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePokemonList = await remoteDataSource.getPokemonList(first);
        localDataSource.cachePokemonList(remotePokemonList);
        return Right(remotePokemonList);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPokemonList = await localDataSource.getLastPokemonList();
        return Right(localPokemonList);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Pokemon>> getPokemonDetail(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePokemonDetail = await remoteDataSource.getPokemonDetail(id);
        localDataSource.cachePokemonDetail(remotePokemonDetail);
        return Right(remotePokemonDetail);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPokemonDetail = await localDataSource.getPokemonDetail(id);
        return Right(localPokemonDetail);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
