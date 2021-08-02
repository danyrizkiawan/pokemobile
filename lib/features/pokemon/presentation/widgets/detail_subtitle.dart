import 'package:flutter/material.dart';

class PokemonDetailsPageSheetTitle extends StatelessWidget {
  const PokemonDetailsPageSheetTitle({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).accentColor,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
    );
  }
}
