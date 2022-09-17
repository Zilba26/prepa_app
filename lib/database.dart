import 'package:mongo_dart/mongo_dart.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DBConnection {


  static final String DB_CONNECTION = dotenv.get('DB_CONNECTION');

  static void addUser(String name, String email, String password) async {
    final db = await Db.create(DB_CONNECTION);
    await db.open();
    final users = db.collection("users");
    
    users.insert({"name": name, "email": email, "password": password});
  }

  static void addUserGoogle(String name, String email, String password, String googleID) async {
    final db = await Db.create(DB_CONNECTION);
    await db.open();
    final users = db.collection("users");

    users.insert({"nom": name, "email": email, "password": password, "googleID": googleID});
  }

  static Future<bool> isRegister(String email) async {
    final db = await Db.create(DB_CONNECTION);
    await db.open();
    final users = await db.collection("users").find().toList();
    for (int i = 0 ; i < users.length ; i++) {
      if (users[i]["email"] == email) {
        return true;
      }
    }
    return false;
  }

  static Future<String> validator(String email, String password) async {
    final db = await Db.create(DB_CONNECTION);
    await db.open();
    final users = await db.collection("users").find().toList();
    for (int i = 0 ; i < users.length ; i++) {
      if (users[i]["email"] == email) {
        if (users[i]["password"] == password) {
          return users[i]["name"];
        } else {
          return "Mot de passe incorrecteeeeeeeeeeeeeeeeeeeeeeeeeeee";
        }
      }
    }
    return "Email non enregistréeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee";
  }
}

