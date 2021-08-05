import 'package:flutter/material.dart';

import '../../../../core/icons/pokedex_ui_icon_icons.dart';

class PokemonListAppBar extends StatelessWidget {
  static const double _appBarHeight = 64.0;
  const PokemonListAppBar({
    Key key,
    @required this.onFilterButtonTap,
  }) : super(key: key);

  final Function onFilterButtonTap;

  @override
  Widget build(BuildContext context) {
    double _statusBarHeight = MediaQuery.of(context).padding.top;
    Size _s = MediaQuery.of(context).size;
    return Positioned(
      top: _statusBarHeight,
      child: Container(
        width: _s.width,
        height: _appBarHeight,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            /* Pokemon Icon */
            Image.asset(
              'assets/images/logo.png',
              height: _appBarHeight * .8,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(width: 12.0),

            /* Title */
            Text(
              'Pokédex',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 24.0,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Expanded(child: SizedBox()),

            /* Filter Button */
            InkWell(
              borderRadius: const BorderRadius.all(
                Radius.circular(100),
              ),
              onTap: onFilterButtonTap,
              child: Container(
                height: 36,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Color(0xFF8C97A7),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      PokedexUiIcon.filter,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(width: 12.0),
                    Text(
                      'Filter',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
