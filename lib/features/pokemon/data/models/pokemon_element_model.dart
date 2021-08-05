import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/pokemon_element.dart';

class PokemonElementModel extends PokemonElement {
  PokemonElementModel({
    @required String name,
    @required Color color,
    @required IconData icon,
  }) : super(name: name, color: color, icon: icon);
}
