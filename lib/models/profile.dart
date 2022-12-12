import 'package:mongo_dart/mongo_dart.dart';

class Profile {
  String id;
  String username;
  String email;

  Profile({required this.id, required this.username, required this.email});

  Profile.fromMap(Map<String, dynamic> map)
      : id = map['_id'],
        username = map['name'],
        email = map['email'];
}