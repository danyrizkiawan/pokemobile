import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:pokemobile/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokemobile/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemobile/features/pokemon/domain/usecases/get_pokemon_list.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  GetPokemonList usecase;
  MockPokemonRepository mockPokemonRepository;

  setUp(() {
    mockPokemonRepository = MockPokemonRepository();
    usecase = GetPokemonList(mockPokemonRepository);
  });

  final tFirst = 1;
  final tPokemonList = [
    Pokemon(
      id: "UG9rZW1vbjowMDE=",
      name: "Bulbasaur",
      image: "https://img.pokemondb.net/artwork/bulbasaur.jpg",
      types: ["Grass", "Poison"],
    ),
  ];
  test('should get pokemon list from repository', () async {
    // arange
    when(mockPokemonRepository.getPokemonList(tFirst))
        .thenAnswer((_) async => Right(tPokemonList));
    // act
    final result = await usecase(Params(first: tFirst));
    // assert
    expect(result, Right(tPokemonList));
    verify(mockPokemonRepository.getPokemonList(tFirst));
    verifyNoMoreInteractions(mockPokemonRepository);
  });
}
