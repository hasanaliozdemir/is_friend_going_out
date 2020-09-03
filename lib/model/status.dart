import 'package:flutter/foundation.dart';

class Status {
  final String userId;
  final String name;
  final bool goingOut;
  final bool haveCar;
  final String goingWhere;

  Status({
    @required this.userId,
    @required this.name,
    @required this.goingOut,
    @required this.haveCar,
    @required this.goingWhere,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'goingOut': goingOut,
      'haveCar': haveCar,
      'goingWhere': goingWhere,
    };
  }
}
