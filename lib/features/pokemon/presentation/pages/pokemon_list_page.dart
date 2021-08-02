import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:pokemobile/core/icons/pokedex_ui_icon_icons.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/pokemon.dart';
import '../bloc/pokemon_list_bloc.dart';
import '../widgets/element_filter_chip.dart';
import '../widgets/pokemon_card.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({Key key}) : super(key: key);

  @override
  _PokemonListPageState createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  /* UI Var */
  static const double _appBarHeight = 64.0;
  double _filterBarHeight = 46.0;

  List<ElementFilterChip> _filterChip = [];

  Map<String, bool> pokemonElements = {
    'Dragon': false,
    'Electric': false,
    'Fairy': false,
    'Fighting': false,
    'Fire': false,
    'Flying': false,
    'Ground': false,
    'Grass': false,
    'Ice': false,
    'Poison': false,
    'Psychic': false,
    'Rock': false,
    'Water': false,
    'Bug': false,
    'Steel': false,
    'Dark': false,
    'Normal': false,
    'Ghost': false,
  };

  bool _hideFilter = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /* UI Dynamic Vars */
    Size _s = MediaQuery.of(context).size;
    double _statusBarHeight = MediaQuery.of(context).padding.top;
    double _mainListTopOffset = _statusBarHeight + _appBarHeight;

    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<PokemonListBloc>(),
        child: Container(
          height: _s.height,
          width: _s.width,
          child: Stack(
            children: [
              //---------- AppBar ----------//
              Positioned(
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
                      _hideFilter
                          ? SizedBox()
                          : InkWell(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(100),
                              ),
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) => StatefulBuilder(
                                    builder: (BuildContext ctx,
                                            StateSetter setState) =>
                                        Container(
                                      height: _s.height * 0.6,
                                      width: _s.width,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: new BorderRadius.only(
                                          topLeft: const Radius.circular(12.0),
                                          topRight: const Radius.circular(12.0),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Theme.of(context)
                                                .primaryColor
                                                .withOpacity(0.1),
                                            blurRadius: 10,
                                            spreadRadius: 5,
                                          )
                                        ],
                                      ),
                                      child: Stack(
                                        children: [
                                          //---------- Main Content ----------//
                                          Column(
                                            children: [
                                              /* Title */
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 16),
                                                child: Text(
                                                  'Filter By',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),

                                              /* Divider */
                                              Container(
                                                height: 1.0,
                                                width: _s.width,
                                                color: Theme.of(context)
                                                    .primaryColor
                                                    .withOpacity(0.1),
                                              ),

                                              /* Elements list */
                                              Expanded(
                                                child: ListView(
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 12,
                                                    bottom: 72 + 12.0,
                                                    left: 8,
                                                    right: 8,
                                                  ),
                                                  children: pokemonElements.keys
                                                      .map((String key) {
                                                    return new CheckboxListTile(
                                                      title: new Text(key),
                                                      value:
                                                          pokemonElements[key],
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .leading,
                                                      activeColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      onChanged: (bool value) {
                                                        setState(() {
                                                          pokemonElements[key] =
                                                              value;
                                                        });
                                                      },
                                                    );
                                                  }).toList(),
                                                ),
                                              )
                                            ],
                                          ),

                                          //---------- Apply Button ----------//
                                          Positioned(
                                            bottom: 0,
                                            child: Container(
                                              width: _s.width,
                                              height: 72.0,
                                              padding: EdgeInsets.all(14.0),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.075),
                                                    blurRadius: 10.0,
                                                    spreadRadius: 5.0,
                                                    offset: Offset(0.0, 1.0),
                                                  )
                                                ],
                                              ),
                                              child: ElevatedButton(
                                                child: Text('Apply'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 36,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
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
              ),

              //---------- Filter Bar ----------//
              _hideFilter
                  ? SizedBox()
                  : Positioned(
                      top: _statusBarHeight + _appBarHeight,
                      child: Container(
                        height: _filterBarHeight,
                        width: _s.width,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFFECECEC),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            /* Title */
                            Container(
                              height: _filterBarHeight - 3.0,
                              width: 110,
                              alignment: Alignment.centerLeft,
                              color: Color(0xFFECECEC),
                              padding: EdgeInsets.only(left: 16),
                              child: Text(
                                'Filtered By: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF8C97A7)),
                              ),
                            ),
                            Expanded(
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                children: _filterChip,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

              //---------- Main List ----------//
              Positioned(
                top: _mainListTopOffset,
                child: Container(
                  width: _s.width,
                  height: _s.height - _mainListTopOffset,
                  child: BlocBuilder<PokemonListBloc, PokemonListState>(
                    builder: (context, state) => PaginationView<Pokemon>(
                      padding: const EdgeInsets.all(16),
                      physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      pageFetch:
                          context.read<PokemonListBloc>().getPokemonsInPage,
                      paginationViewType: PaginationViewType.gridView,
                      itemBuilder:
                          (BuildContext ctx, Pokemon pokemon, int index) =>
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
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
