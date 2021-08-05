import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

class PokemonElement extends Equatable {
  final String name;
  final Color color;
  final IconData icon;

  PokemonElement({
    @required this.name,
    @required this.color,
    @required this.icon,
  }) : super();

  @override
  List<Object> get props => [name, color, icon];
}
