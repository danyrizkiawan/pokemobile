import 'package:flutter/material.dart';

import '../../domain/entities/pokemon.dart';
import '../pages/pokemon_details_page.dart';

class EvolutionsWidget extends StatelessWidget {
  const EvolutionsWidget({
    Key key,
    @required this.evolutions,
  }) : super(key: key);

  final List<Pokemon> evolutions;

  @override
  Widget build(BuildContext context) {
    return evolutions == null || evolutions.isEmpty
        ? SizedBox()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /* Title */
                Text(
                  'Evolution',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),

                /* Evolution Image */
                Row(
                  children: evolutions
                      .map((p) => EvolutionCard(
                            pokemon: p,
                          ))
                      .toList(),
                )
              ],
            ),
          );
  }
}

class EvolutionCard extends StatelessWidget {
  const EvolutionCard({
    Key key,
    @required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.05),
            blurRadius: 5,
            spreadRadius: 2,
          )
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => PokemonDetailsPage(pokemon: pokemon),
          ));
        },
        child: Image.network(
          pokemon.image,
          cacheHeight: 100,
          cacheWidth: 100,
          errorBuilder: (context, object, _) =>
              Image.asset('assets/images/no_image.png'),
        ),
      ),
    );
  }
}
