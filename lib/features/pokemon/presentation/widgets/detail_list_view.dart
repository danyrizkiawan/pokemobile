import 'package:flutter/material.dart';
import 'package:pokemobile/core/icons/pokedex_ui_icon_icons.dart';

import '../../../../core/util/mapper.dart';
import '../../domain/entities/pokemon.dart';
import 'detail_about.dart';
import 'detail_subtitle.dart';

class DetailListView extends StatelessWidget {
  const DetailListView({
    Key key,
    @required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /* About */
          PokemonDetailsPageSheetTitle(title: 'About'),
          Container(
            height: 100,
            margin: EdgeInsets.only(top: 6),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /* Weight */
                PokemonDetailsPageAbout(
                  icon: PokedexUiIcon.scales,
                  text: Mapper.dimensionFormatter(
                    pokemon.weight.minimum,
                    pokemon.weight.maximum,
                  ),
                  title: 'Weight',
                ),
                Container(
                  width: 1,
                  margin: EdgeInsets.symmetric(vertical: 12),
                  color: Colors.black.withOpacity(0.1),
                ),

                /* Height */
                PokemonDetailsPageAbout(
                  icon: PokedexUiIcon.ruler,
                  text: Mapper.dimensionFormatter(
                    pokemon.height.minimum,
                    pokemon.height.maximum,
                  ),
                  title: 'Height',
                ),
                Container(
                  width: 1,
                  margin: EdgeInsets.symmetric(vertical: 12),
                  color: Colors.black.withOpacity(0.1),
                ),

                /* Classification */
                PokemonDetailsPageAbout(
                  icon: PokedexUiIcon.ruler,
                  text: pokemon.classification ?? 'No Data',
                  title: 'Classification',
                  isClasssification: true,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          /* Fast Attacks */
          PokemonDetailsPageSheetTitle(
            title: 'Fast Attacks',
          ),
          pokemon.attacks == null || pokemon.attacks.fast == null
              ? Text("No fast attacks.")
              : Text(
                  Mapper.listToString(
                    pokemon.attacks.fast
                        .map((e) => Mapper.attackFormatter(e))
                        .toList(),
                  ),
                ),
          SizedBox(height: 20),

          /* Special Attacks */
          PokemonDetailsPageSheetTitle(
            title: 'Special Attacks',
          ),
          pokemon.attacks == null || pokemon.attacks.special == null
              ? Text("No special attacks.")
              : Text(
                  Mapper.listToString(
                    pokemon.attacks.special
                        .map((e) => Mapper.attackFormatter(e))
                        .toList(),
                  ),
                ),
          SizedBox(height: 20),

          /* Resistances */
          PokemonDetailsPageSheetTitle(
            title: 'Resistances',
          ),
          pokemon.resistant == null
              ? Text('No resistances.')
              : Wrap(
                  spacing: 6,
                  children: pokemon.resistant.map((String element) {
                    return Mapper.elementsChipCreator(element);
                  }).toList(),
                ),
          SizedBox(height: 20),

          /* Weaknesses */
          PokemonDetailsPageSheetTitle(
            title: 'Weaknesses',
          ),
          pokemon.weaknesses == null
              ? Text('No weaknesses.')
              : Wrap(
                  spacing: 6,
                  children: pokemon.weaknesses.map((String element) {
                    return Mapper.elementsChipCreator(element);
                  }).toList(),
                ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
