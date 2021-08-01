import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Attack extends Equatable {
  final String name;
  final String type;
  final int damage;

  Attack({
    @required this.name,
    @required this.type,
    @required this.damage,
  });

  @override
  List<Object> get props => [name, type, damage];
}
