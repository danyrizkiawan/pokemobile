import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:pokemobile/features/pokemon/domain/entities/attack.dart';
import 'package:pokemobile/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokemobile/features/pokemon/domain/entities/pokemon_attack.dart';
import 'package:pokemobile/features/pokemon/domain/entities/pokemon_dimension.dart';
import 'package:pokemobile/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemobile/features/pokemon/domain/usecases/get_pokemon_detail.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  GetPokemonDetail usecase;
  MockPokemonRepository mockPokemonRepository;

  setUp(() {
    mockPokemonRepository = MockPokemonRepository();
    usecase = GetPokemonDetail(mockPokemonRepository);
  });

  final tPokemonID = "UG9rZW1vbjowMDE=";
  final tPokemonDetail = Pokemon(
    id: "id",
    name: "Bulbasaur",
    image: "https://img.pokemondb.net/artwork/bulbasaur.jpg",
    weight: PokemonDimension(minimum: "6.04kg", maximum: "7.76kg"),
    height: PokemonDimension(minimum: "0.61m", maximum: "0.79m"),
    classification: "Seed Pokémon",
    types: [
      "Grass",
      "Poison",
    ],
    attacks: PokemonAttack(
      fast: [
        Attack(name: "Tackle", type: "Normal", damage: 12),
        Attack(name: "Vine Whip", type: "Grass", damage: 7),
      ],
      special: [
        Attack(name: "Power Whip", type: "Grass", damage: 70),
        Attack(name: "Seed Bomb", type: "Grass", damage: 40),
        Attack(name: "Sludge Bomb", type: "Poison", damage: 55),
      ],
    ),
    resistant: ["Water", "Electric", "Grass", "Fighting", "Fairy"],
    weaknesses: ["Fire", "Ice", "Flying", "Psychic"],
    evolutions: [
      Pokemon(
          id: "UG9rZW1vbjowMDI=",
          name: "Ivysaur",
          image: "https://img.pokemondb.net/artwork/ivysaur.jpg"),
      Pokemon(
          id: "UG9rZW1vbjowMDM=",
          name: "Venusaur",
          image: "https://img.pokemondb.net/artwork/venusaur.jpg"),
    ],
  );
  test('should get pokemon detail from repository', () async {
    // arange
    when(mockPokemonRepository.getPokemonDetail(tPokemonID))
        .thenAnswer((_) async => Right(tPokemonDetail));
    // act
    final result = await usecase(Params(id: tPokemonID));
    // assert
    expect(result, Right(tPokemonDetail));
    verify(mockPokemonRepository.getPokemonDetail(tPokemonID));
    verifyNoMoreInteractions(mockPokemonRepository);
  });
}
