import 'package:flutter/material.dart';

import '../../domain/entities/pokemon_element.dart';

class ElementDetailChip extends StatelessWidget {
  const ElementDetailChip({Key key, @required this.element}) : super(key: key);

  final PokemonElement element;

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: element.color,
      labelPadding: EdgeInsets.only(right: 6),
      label: Text(
        element.name,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      avatar: Icon(
        element.icon,
        size: 14,
        color: Colors.white,
      ),
    );
  }
}
