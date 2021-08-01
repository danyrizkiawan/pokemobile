import 'package:meta/meta.dart';

import '../../domain/entities/attack.dart';

class AttackModel extends Attack {
  AttackModel({
    @required String name,
    @required String type,
    @required int damage,
  }) : super(name: name, type: type, damage: damage);

  factory AttackModel.fromJson(Map<String, dynamic> json) {
    return AttackModel(
      name: json['name'],
      type: json['type'],
      damage: (json['damage'] as num).toInt(),
    );
  }
}
