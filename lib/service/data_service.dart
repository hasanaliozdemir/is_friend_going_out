import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:is_friend_going_out/model/models.dart';
import 'package:is_friend_going_out/service/services.dart';

class DataService {
  String userId;
  DataService({this.userId});

  /// user collection reference
  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  /// room collection reference
  final CollectionReference roomsCollection =
      Firestore.instance.collection('rooms');

  /// stream for gettin rooms
  Stream<List<Room>> get rooms {
    return roomsCollection
        .where("users", arrayContains: userId)
        .snapshots()
        .map(roomListFromSnapshot);
  }

  /// Room List From Snapshot
  List<Room> roomListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .map(
          (doc) => Room(
            id: doc.data['id'],
            name: doc.data['name'],
            users: List<String>.from(doc.data['users']),
            status: List<Status>.from(
              doc.data['status'].map(
                (item) {
                  return new Status(
                    userId: item['userId'],
                    name: item['name'],
                    goingOut: item['goingOut'],
                    haveCar: item['haveCar'],
                    goingWhere: item['goingWhere'],
                  );
                },
              ),
            ),
          ),
        )
        .toList();
  }

  /// Create User
  Future createUserData({
    String uid,
    String name,
    String username,
    String gender,
  }) async {
    return await usersCollection.document(uid).setData(
          User(
            id: uid,
            name: name,
            username: username,
            gender: gender,
            rooms: [],
          ).toJson(),
        );
  }

  /// Create Room
  Future createRoomData({
    String name,
    List<String> users,
  }) async {
    String roomId = roomsCollection.document().documentID;

    Iterable<Future<Status>> mappedList = users.map(
      (username) async => await getUserFromUsername(username: username).then(
        (user) => Status(
          goingOut: false,
          goingWhere: '',
          haveCar: false,
          name: user.name,
          userId: user.id,
        ),
      ),
    );

    Future<List<Status>> futureList = Future.wait(mappedList);
    List<Status> statusList = await futureList;

    users.clear();
    statusList.forEach((element) {
      users.add(element.userId);
    });

    Room roomData = Room(
      id: roomId,
      name: name,
      users: users,
      status: statusList,
    );

    return await roomsCollection.document(roomId).setData(roomData.toJson());
  }

  /// Add User to Room
  Future addUserToRoom({Room room, String username}) async {
    String roomId = room.id;

    Status userStatus = await getUserFromUsername(username: username).then(
      (user) => Status(
        goingOut: false,
        goingWhere: '',
        haveCar: false,
        name: user.name,
        userId: user.id,
      ),
    );

    room.users.add(userStatus.userId);
    room.status.add(userStatus);

    Room roomData = Room(
      id: roomId,
      name: room.name,
      users: room.users,
      status: room.status,
    );
    return await roomsCollection.document(roomId).updateData(roomData.toJson());
  }

  /// Remove User From Room
  Future removeUserFromRoom({Room room}) async {
    String roomId = room.id;

    Status userStatus = await getCurrentUser().then(
      (user) => Status(
        goingOut: false,
        goingWhere: '',
        haveCar: false,
        name: user.name,
        userId: user.id,
      ),
    );

    room.users.remove(userStatus.userId);
    room.status.removeWhere((item) => item.userId == userStatus.userId);

    Room roomData = Room(
      id: roomId,
      name: room.name,
      users: room.users,
      status: room.status,
    );
    return await roomsCollection.document(roomId).setData(roomData.toJson());
  }

  /// Get User By User ID
  Future getUserDataById({String userId}) async {
    return await usersCollection.document(userId).get().then(
          (doc) => User(
            id: doc.data['id'] ?? '',
            name: doc.data['name'] ?? '',
            username: doc.data['username'] ?? '',
            gender: doc.data['gender'] ?? 'Other',
            rooms: List.from(doc.data['rooms'] ?? []),
          ),
        );
  }

  /// Get Room By User ID
  Future getRoomDataById({String roomId}) async {
    return await roomsCollection.document(roomId).get().then(
          (doc) => Room(
            id: doc.data['id'] ?? '',
            name: doc.data['name'] ?? '',
            status: List<Status>.from(
                  doc.data['users'].map(
                    (item) {
                      return new Status(
                        userId: item['userId'] ?? '',
                        name: item['name'] ?? '',
                        goingOut: item['goingOut'] ?? false,
                        haveCar: item['haveCar'] ?? false,
                        goingWhere: item['goingWhere'] ?? '',
                      );
                    },
                  ),
                ) ??
                [],
            users: List<String>.from(doc.data['users'] ?? []),
          ),
        );
  }

  /// Update User Data
  Future updateUserData({User user}) async {
    return await usersCollection.document(userId).updateData(user.toJson());
  }

  /// Update Room Data
  Future updateRoomData({Room room}) async {
    return await roomsCollection.document(room.id).updateData(room.toJson());
  }

  /// Get User From Username
  Future getUserFromUsername({@required String username}) async {
    return await usersCollection
        .where("username", isEqualTo: username)
        .getDocuments()
        .then(
      (doc) {
        if (doc.documents.length == 0)
          return PlatformException(
            code: 'user_not_exist',
            details: 'This user not exist.',
            message: 'This user not exist.',
          );
        return User(
          id: doc.documents.first.data['id'] ?? '',
          name: doc.documents.first.data['name'] ?? '',
          username: doc.documents.first.data['username'] ?? '',
          gender: doc.documents.first.data['gender'] ?? 'Other',
          rooms: List.from(doc.documents.first.data['rooms'] ?? []),
        );
      },
    );
  }

  /// Check Username exist or not
  Future checkUserName({@required String username}) async {
    return await usersCollection
        .where("username", isEqualTo: username.toLowerCase())
        .getDocuments()
        .then((doc) => doc.documents.length);
  }

  /// Get Current User
  Future getCurrentUser() async {
    String currentUserID = await AuthService().getCurrentUserId();
    return await getUserDataById(userId: currentUserID);
  }
}
