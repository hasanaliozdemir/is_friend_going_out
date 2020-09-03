import 'package:flutter/foundation.dart';

import 'models.dart';

class Room {
  final String id;
  final String name;
  final List<Status> status;
  final List<String> users;

  Room({
    @required this.id,
    @required this.name,
    @required this.status,
    @required this.users,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status.map((data) => data.toJson()).toList(),
      'users': users.toList(),
    };
  }
}
