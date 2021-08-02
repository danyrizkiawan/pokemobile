import 'package:flutter/material.dart';

class PokemonDetailsPageAbout extends StatelessWidget {
  const PokemonDetailsPageAbout({
    Key key,
    this.isClasssification = false,
    @required this.text,
    @required this.icon,
    @required this.title,
  }) : super(key: key);

  final bool isClasssification;
  final String text;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: 4,
          ),
          Expanded(
            child: isClasssification
                ? Align(
                    alignment: Alignment.center,
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(icon),
                      SizedBox(width: 8),
                      Text(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: .9,
                        ),
                      )
                    ],
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(title),
          )
        ],
      ),
    );
  }
}
