import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/mapper.dart';
import '../../../../injection_container.dart';
import '../../data/models/pokemon_element_model.dart';
import '../bloc/pokemon_list_bloc.dart';
import '../widgets/element_filter_chip.dart';
import '../widgets/pokemon_appbar.dart';
import '../widgets/pokemon_pagination.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({Key key}) : super(key: key);

  @override
  _PokemonListPageState createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  PokemonListBloc pokemonListBloc;
  /* UI Var */
  static const double _appBarHeight = 64.0;
  double _filterBarHeight = 46.0;

  List<String> _selectedElementString = [];
  List<PokemonElementModel> _selectedElements = [];

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

  @override
  void initState() {
    super.initState();
    pokemonListBloc = sl.get<PokemonListBloc>();
  }

  @override
  Widget build(BuildContext context) {
    /* UI Dynamic Vars */
    Size _s = MediaQuery.of(context).size;
    double _statusBarHeight = MediaQuery.of(context).padding.top;
    double _mainListTopOffset = _statusBarHeight + _appBarHeight;
    if (_selectedElementString.length > 0) {
      _mainListTopOffset += _filterBarHeight;
    }

    return Scaffold(
      body: BlocProvider(
        create: (context) => pokemonListBloc,
        child: Container(
          height: _s.height,
          width: _s.width,
          child: Stack(
            children: [
              //---------- AppBar ----------//
              PokemonListAppBar(
                onFilterButtonTap: onFilterButtonTap,
              ),

              //---------- Filter Bar ----------//
              Positioned(
                top: _statusBarHeight + _appBarHeight,
                child: AnimatedCrossFade(
                  crossFadeState: _selectedElementString.isEmpty
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  firstChild: SizedBox(),
                  secondChild: Container(
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
                              color: Color(0xFF8C97A7),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            itemCount: _selectedElements.length,
                            itemBuilder: (context, index) => ElementFilterChip(
                              element: _selectedElements[index],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  duration: Duration(milliseconds: 500),
                ),
              ),

              //---------- Main List ----------//
              Positioned(
                top: _mainListTopOffset,
                child: Container(
                  width: _s.width,
                  height: _s.height - _mainListTopOffset,
                  child: BlocBuilder<PokemonListBloc, PokemonListState>(
                    builder: (context, state) {
                      if (state is PokemonListFiltered) {
                        String key = _selectedElementString.join(',');
                        return PokemonsPaginationView(
                          key: Key(key),
                          pageFetch: (offset) => context
                              .read<PokemonListBloc>()
                              .getFilteredPokemonsInPage(
                                offset,
                                _selectedElementString,
                              ),
                        );
                      }
                      return PokemonsPaginationView(
                        key: Key('normalPage'),
                        pageFetch:
                            context.read<PokemonListBloc>().getPokemonsInPage,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onFilterButtonTap() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext ctx, StateSetter ss) {
          Size _s = MediaQuery.of(context).size;
          return Container(
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
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
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
                      padding: const EdgeInsets.symmetric(vertical: 16),
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
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                    ),

                    /* Elements list */
                    Expanded(
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(
                          top: 12,
                          bottom: 72 + 12.0,
                          left: 8,
                          right: 8,
                        ),
                        children: pokemonElements.keys.map((String key) {
                          return new CheckboxListTile(
                            title: new Text(key),
                            value: pokemonElements[key],
                            controlAffinity: ListTileControlAffinity.leading,
                            activeColor: Theme.of(context).primaryColor,
                            onChanged: (bool value) {
                              ss(
                                () {
                                  pokemonElements[key] = value;
                                },
                              );
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
                          color: Colors.black.withOpacity(0.075),
                          blurRadius: 10.0,
                          spreadRadius: 5.0,
                          offset: Offset(0.0, 1.0),
                        )
                      ],
                    ),
                    child: ElevatedButton(
                      child: Text('Apply'),
                      onPressed: () {
                        Map<String, bool> selected = Map<String, bool>.from(
                          pokemonElements,
                        );
                        selected.removeWhere((key, value) => !value);
                        _selectedElements.clear();
                        _selectedElementString.clear();
                        selected.forEach((key, value) {
                          _selectedElementString.add(key);
                          _selectedElements.add(
                            Mapper.getPokemonElement(key),
                          );
                        });
                        setState(() {});
                        if (_selectedElementString.length > 0) {
                          pokemonListBloc.add(
                            FilterPokemons(),
                          );
                        } else {
                          pokemonListBloc.add(GetAllPokemons());
                        }
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
