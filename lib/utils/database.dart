import 'package:mongo_dart/mongo_dart.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:prepa_app/models/filiere.dart';

import '../models/concours.dart';
import '../models/ecole.dart';

class DBConnection {


  static final String DB_CONNECTION = dotenv.get('DB_CONNECTION');
  static late Db db;
  static Map<int, List<Ecole>> schools = {};

  static Future<void> init() async {
    db = await Db.create(DB_CONNECTION);
    await db.open();
    await initSchools();
    print("DB connection initialized");
  }

  static Future<void> initSchools() async {
    final DbCollection coll = db.collection('schools');
    List<Map> schoolsList = await coll.find().toList();
    for (Map school in schoolsList) {
      Ecole e = Ecole.fromMap(school);
      if (schools.containsKey(e.annee)) {
        schools[e.annee]!.add(e);
      } else {
        schools[e.annee] = [e];
      }
    }
  }

  static List<Ecole> getSchools(int annee, Concours concours, Filiere filiere) {
    if (schools.containsKey(annee)) {
      List<Ecole> ecoles = schools[annee]!;
      ecoles.forEach((element) {print("${element.name} - ${element.concours} ${element.filiere}");});
      print(concours);
      print(filiere);
      List<Ecole> result = ecoles.where((element) => element.concours == concours && element.filiere == filiere).toList();
      return result;
    } else {
      return [];
    }
  }

  static void addUser(String name, String email, String password) async {
    final users = db.collection("users");
    
    users.insert({"name": name, "email": email, "password": password});
  }

  static void addUserGoogle(String name, String email, String password, String googleID) async {
    final users = db.collection("users");

    users.insert({"nom": name, "email": email, "password": password, "googleID": googleID});
  }

  static Future<bool> isRegister(String email) async {
    final users = await db.collection("users").find().toList();
    for (int i = 0 ; i < users.length ; i++) {
      if (users[i]["email"] == email) {
        return true;
      }
    }
    return false;
  }

  static Future<String> validator(String email, String password) async {
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

