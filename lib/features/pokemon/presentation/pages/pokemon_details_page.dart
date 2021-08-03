import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/mapper.dart';
import '../../../../injection_container.dart';
import '../../data/models/pokemon_model.dart';
import '../bloc/pokemon_detail_bloc.dart';
import '../bloc/pokemon_list_bloc.dart';
import '../widgets/detail_evolutions.dart';
import '../widgets/detail_list_view.dart';
import '../widgets/loading_display.dart';
import '../widgets/message_display.dart';

class PokemonDetailsPage extends StatelessWidget {
  const PokemonDetailsPage({
    Key key,
    @required this.pokemon,
  }) : super(key: key);

  final PokemonModel pokemon;

  @override
  Widget build(BuildContext context) {
    Size _s = MediaQuery.of(context).size;
    double _r = _s.height / _s.width;
    double _threshold = 1.8;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: pokemon.types == null
              ? Theme.of(context).cardColor
              : Mapper.pokemonMainElementColor(
                  pokemon.types?.first ?? 'normal',
                ), //change your color here
        ),
        actions: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 16),
            child: Text(
              '#001',
              style: TextStyle(
                color: pokemon.types == null
                    ? Theme.of(context).cardColor
                    : Mapper.pokemonMainElementColor(
                        pokemon.types?.first ?? 'normal',
                      ),
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      body: BlocProvider(
        create: (_) => sl<PokemonDetailBloc>(),
        child: SizedBox.expand(
          child: Stack(
            children: [
              //---------- Image and Evolution ----------//
              Container(
                width: _s.width,
                height: _r > _threshold ? _s.height * 0.4 : _s.height * 0.35,
                margin: EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    /* Image */
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 48),
                        child: Image.network(
                          pokemon.image,
                          fit: BoxFit.contain,
                          cacheHeight: 200,
                          cacheWidth: 200,
                          errorBuilder: (context, object, _) => Image.asset(
                            'assets/images/no_image.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),

                    /* Evolution */
                    BlocBuilder<PokemonDetailBloc, PokemonDetailState>(
                      builder: (context, state) {
                        if (state is PokemonDetailInitial) {
                          context
                              .read<PokemonDetailBloc>()
                              .add(GetPokemon(id: pokemon.id));
                        } else if (state is PokemonDetailLoaded) {
                          return EvolutionsWidget(
                            evolutions: state.pokemon.evolutions,
                          );
                        }
                        return SizedBox();
                      },
                    ),
                  ],
                ),
              ),

              //---------- Details ----------//
              SizedBox.expand(
                child: DraggableScrollableSheet(
                  initialChildSize: .5,
                  minChildSize: .5,
                  maxChildSize: .95,
                  builder: (
                    BuildContext context,
                    ScrollController scrollController,
                  ) =>
                      Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(20.0),
                        topRight: const Radius.circular(20.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade500,
                          blurRadius: 10.0,
                        )
                      ],
                    ),
                    child: ListView(
                      controller: scrollController,
                      physics: BouncingScrollPhysics(),
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              pokemon.name,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            BlocBuilder<PokemonDetailBloc, PokemonDetailState>(
                              builder: (context, state) {
                                if (state is PokemonDetailLoaded) {
                                  if (state.pokemon.types == null) {
                                    return SizedBox();
                                  }
                                  return Row(
                                    children: state.pokemon.types
                                        .map((String element) {
                                      return Padding(
                                        padding: EdgeInsets.only(left: 8),
                                        child:
                                            Mapper.elementsChipCreator(element),
                                      );
                                    }).toList(),
                                  );
                                }
                                return SizedBox();
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),

                        /* Divider */
                        Container(
                          height: 1.0,
                          width: _s.width,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                        ),

                        /* Main Scrollview */
                        Expanded(
                          child: BlocBuilder<PokemonDetailBloc,
                              PokemonDetailState>(
                            builder: (context, state) {
                              if (state is PokemonDetailInitial) {
                                return LoadingDisplay();
                              } else if (state is PokemonListLoading) {
                                return LoadingDisplay();
                              } else if (state is PokemonDetailLoaded) {
                                return DetailListView(pokemon: state.pokemon);
                              } else if (state is PokemonDetailError) {
                                return MessageDisplay(message: state.message);
                              }
                              return SizedBox();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
