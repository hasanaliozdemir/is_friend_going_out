import 'package:flutter/foundation.dart';

class User {
  final String id;
  final String name;
  final String username;
  final String gender;
  final List<String> rooms;

  User({
    @required this.id,
    @required this.name,
    @required this.username,
    @required this.gender,
    @required this.rooms,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'gender': gender,
      'rooms': rooms.toList(),
    };
  }
}
