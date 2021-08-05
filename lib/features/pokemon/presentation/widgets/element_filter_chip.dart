import 'package:flutter/material.dart';

import '../../domain/entities/pokemon_element.dart';

class ElementFilterChip extends StatelessWidget {
  const ElementFilterChip({Key key, @required this.element}) : super(key: key);

  final PokemonElement element;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      margin: EdgeInsets.only(
        right: 6,
        top: 6,
        bottom: 6,
      ),
      decoration: BoxDecoration(
        color: element.color,
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
      ),
      child: Row(
        children: [
          Icon(
            element.icon,
            size: 16,
            color: Colors.white,
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            element.name,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
