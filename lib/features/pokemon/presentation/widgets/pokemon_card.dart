import 'package:flutter/material.dart';
import 'package:pokemobile/core/util/mapper.dart';

import '../../data/models/pokemon_model.dart';
import '../pages/pokemon_details_page.dart';

class PokemonCard extends StatelessWidget {
  final PokemonModel pokemon;
  const PokemonCard({
    Key key,
    @required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PokemonDetailsPage(
              pokemon: pokemon,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            color: pokemon.types == null
                ? Theme.of(context).cardColor
                : Mapper.getPokemonElementColor(
                    pokemon.types?.first ?? 'normal',
                  ),
            width: 2.0,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.network(
                  pokemon.image,
                  errorBuilder: (context, object, _) =>
                      Image.asset('assets/images/no_image.png'),
                ),
              ),
            ),
            Container(
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: pokemon.types == null
                    ? Theme.of(context).cardColor
                    : Mapper.getPokemonElementColor(
                        pokemon.types?.first ?? 'normal',
                      ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Text(
                pokemon.name,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
