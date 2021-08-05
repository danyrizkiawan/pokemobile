import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pagination_view/pagination_view.dart';

import '../../domain/entities/pokemon.dart';
import 'pokemon_card.dart';

class PokemonsPaginationView extends StatelessWidget {
  const PokemonsPaginationView({
    Key key,
    @required this.pageFetch,
  })  : _key = key,
        super(key: key);
  final Function pageFetch;
  final Key _key;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return PaginationView<Pokemon>(
          key: _key,
          padding: const EdgeInsets.all(16),
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
            childAspectRatio: 1,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          pageFetch: pageFetch,
          paginationViewType: PaginationViewType.gridView,
          itemBuilder: (BuildContext ctx, Pokemon pokemon, int index) =>
              PokemonCard(pokemon: pokemon),
          onEmpty: SizedBox(),
          onError: (exception) => SizedBox(),
          bottomLoader: Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).cardColor,
            ),
          ),
          initialLoader: Center(
            child: SpinKitThreeBounce(
              color: Theme.of(context).cardColor,
              size: 30.0,
            ),
          ),
        );
      },
    );
  }
}
