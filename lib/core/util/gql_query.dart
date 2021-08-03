mixin GqlQuery {
  static String pokemonListQuery = '''
    query PokemonDetail(\$first: Int!) {
      pokemons(first: \$first) {
        id
        name
        image
        types
      }
    }
  ''';

  static String pokemonDetailQuery = '''
    query PokemonDetail(\$id: String!) {
    pokemon(id: \$id) {
      id
      number
      name
      image
      weight {
        minimum
        maximum
      }
      height {
        minimum
        maximum
      }
      classification
      types
      attacks {
        fast {
          name
          type
          damage
        }
        special {
          name
          type
          damage
        }
      }
      resistant
      weaknesses
      evolutions {
        id
        image
        name
        types
      }
    }
  }
  ''';
}
