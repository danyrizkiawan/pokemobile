import 'package:flutter/material.dart';

import '../../features/pokemon/data/models/pokemon_element_model.dart';
import '../../features/pokemon/domain/entities/attack.dart';
import '../icons/pokemon_element_icon_icons.dart';

class Mapper {
  static Map<String, PokemonElementModel> elementList = {
    'dragon': PokemonElementModel(
      name: 'Dragon',
      color: Color(0xFF0773C8),
      icon: PokemonElementIcon.dragon,
    ),
    'electric': PokemonElementModel(
      name: 'Electric',
      color: Color(0xFFEFD743),
      icon: PokemonElementIcon.electric,
    ),
    'fairy': PokemonElementModel(
      name: 'Fairy',
      color: Color(0xFFED8EE5),
      icon: PokemonElementIcon.fairy,
    ),
    'fighting': PokemonElementModel(
      name: 'Fighting',
      color: Color(0xFFDB4256),
      icon: PokemonElementIcon.fighting,
    ),
    'fire': PokemonElementModel(
      name: 'Fire',
      color: Color(0xFFFBA54B),
      icon: PokemonElementIcon.fire,
    ),
    'flying': PokemonElementModel(
      name: 'Flying',
      color: Color(0xFF95ADDF),
      icon: PokemonElementIcon.flying,
    ),
    'ground': PokemonElementModel(
      name: 'Ground',
      color: Color(0xFFD88352),
      icon: PokemonElementIcon.ground,
    ),
    'grass': PokemonElementModel(
      name: 'Grass',
      color: Color(0xFF5EBD58),
      icon: PokemonElementIcon.grass,
    ),
    'ice': PokemonElementModel(
      name: 'Ice',
      color: Color(0xFF74CFC1),
      icon: PokemonElementIcon.ice,
    ),
    'poison': PokemonElementModel(
      name: 'Poison',
      color: Color(0xFFB163CC),
      icon: PokemonElementIcon.poison,
    ),
    'psychic': PokemonElementModel(
      name: 'Psychic',
      color: Color(0xFFFA8681),
      icon: PokemonElementIcon.psychic,
    ),
    'rock': PokemonElementModel(
      name: 'Rock',
      color: Color(0xFFCEC08C),
      icon: PokemonElementIcon.rock,
    ),
    'water': PokemonElementModel(
      name: 'Water',
      color: Color(0xFF59A4E0),
      icon: PokemonElementIcon.water,
    ),
    'bug': PokemonElementModel(
      name: 'Bug',
      color: Color(0xFFA4C432),
      icon: PokemonElementIcon.bug,
    ),
    'steel': PokemonElementModel(
      name: 'Steel',
      color: Color(0xFF5699A5),
      icon: PokemonElementIcon.steel,
    ),
    'dark': PokemonElementModel(
      name: 'Dark',
      color: Color(0xFF636775),
      icon: PokemonElementIcon.dark,
    ),
    'normal': PokemonElementModel(
      name: 'Normal',
      color: Color(0xFF979CA3),
      icon: PokemonElementIcon.normal,
    ),
    'ghost': PokemonElementModel(
      name: 'Ghost',
      color: Color(0xFF6770C3),
      icon: PokemonElementIcon.ghost,
    ),
  };

  static PokemonElementModel getPokemonElement(String key) =>
      elementList[key.toLowerCase()] ?? null;

  static Color getPokemonElementColor(String key) =>
      elementList[key.toLowerCase()]?.color ?? Color(0xFF979CA3);

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
