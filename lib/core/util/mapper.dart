import 'package:flutter/material.dart';
import 'package:pokemobile/core/icons/pokemon_element_icon_icons.dart';

import '../../features/pokemon/domain/entities/attack.dart';
import '../../features/pokemon/presentation/widgets/element_detail_chip.dart';

class Mapper {
  static Color pokemonMainElementColor(String element) {
    Color color;

    switch (element.toLowerCase()) {
      case 'dragon':
        color = Color(0xFF0773C8);
        break;
      case 'electric':
        color = Color(0xFFEFD743);
        break;
      case 'fairy':
        color = Color(0xFFED8EE5);
        break;
      case 'fighting':
        color = Color(0xFFDB4256);
        break;
      case 'fire':
        color = Color(0xFFFBA54B);
        break;
      case 'flying':
        color = Color(0xFF95ADDF);
        break;
      case 'ground':
        color = Color(0xFFD88352);
        break;
      case 'grass':
        color = Color(0xFF5EBD58);
        break;
      case 'ice':
        color = Color(0xFF74CFC1);
        break;
      case 'poison':
        color = Color(0xFFB163CC);
        break;
      case 'psychic':
        color = Color(0xFFFA8681);
        break;
      case 'rock':
        color = Color(0xFFCEC08C);
        break;
      case 'water':
        color = Color(0xFF59A4E0);
        break;
      case 'bug':
        color = Color(0xFFA4C432);
        break;
      case 'steel':
        color = Color(0xFF5699A5);
        break;
      case 'dark':
        color = Color(0xFF636775);
        break;
      case 'normal':
        color = Color(0xFF979CA3);
        break;
      case 'ghost':
        color = Color(0xFF6770C3);
        break;
      default:
        color = Color(0xFF979CA3);
        break;
    }

    return color;
  }

  static Widget elementsChipCreator(String element) {
    IconData icon;

    switch (element.toLowerCase()) {
      case 'dragon':
        icon = PokemonElementIcon.dragon;
        break;
      case 'electric':
        icon = PokemonElementIcon.electric;
        break;
      case 'fairy':
        icon = PokemonElementIcon.fairy;
        break;
      case 'fighting':
        icon = PokemonElementIcon.fighting;
        break;
      case 'fire':
        icon = PokemonElementIcon.fire;
        break;
      case 'flying':
        icon = PokemonElementIcon.flying;
        break;
      case 'ground':
        icon = PokemonElementIcon.ground;
        break;
      case 'grass':
        icon = PokemonElementIcon.grass;
        break;
      case 'ice':
        icon = PokemonElementIcon.ice;
        break;
      case 'poison':
        icon = PokemonElementIcon.poison;
        break;
      case 'psychic':
        icon = PokemonElementIcon.psychic;
        break;
      case 'rock':
        icon = PokemonElementIcon.rock;
        break;
      case 'water':
        icon = PokemonElementIcon.water;
        break;
      case 'bug':
        icon = PokemonElementIcon.bug;
        break;
      case 'steel':
        icon = PokemonElementIcon.steel;
        break;
      case 'dark':
        icon = PokemonElementIcon.dark;
        break;
      case 'normal':
        icon = PokemonElementIcon.normal;
        break;
      case 'ghost':
        icon = PokemonElementIcon.ghost;
        break;
      default:
        icon = PokemonElementIcon.normal;
        break;
    }

    return ElementDetailChip(
      color: pokemonMainElementColor(element),
      icon: icon,
      title: element.capitalize(),
    );
  }

  static String dimensionFormatter(String min, String max) {
    return '$min\n-\n$max';
  }

  static String listToString(List<String> list) {
    return list.join(', ');
  }

  static String attackFormatter(Attack attack) {
    return '${attack.name} (${attack.type})';
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
