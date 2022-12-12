import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:prepa_app/models/filiere.dart';
import 'package:http/http.dart' as http;

import '../models/concours.dart';
import '../models/ecole.dart';

class DBConnection {


  static final String DB_CONNECTION = dotenv.get('DB_CONNECTION');
  //static late Db db;
  static Map<int, List<Ecole>> schools = {};

  // static Future<void> init() async {
  //   db = await Db.create(DB_CONNECTION);
  //   await db.open();
  //   await initSchools();
  //   print("DB connection initialized");
  // }

  static Future<void> initSchools() async {
    // final DbCollection coll = db.collection('schools');
    // List<Map> schoolsList = await coll.find().toList();
    Uri url = Uri.https('prepa-stat.vercel.app', '/api/schools', {"annee": "2021"});
    http.Response response = await http.get(url);
    List schoolsList = json.decode(utf8.decode(response.bodyBytes));
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
      List<Ecole> result = ecoles.where((element) => element.concours == concours && element.filiere == filiere).toList();
      return result;
    } else {
      return [];
    }
  }

  static List<Ecole> getFavorites() {
    return [];
  }

  static Future<Map> login(String email, String password, bool remember) async {
    Uri url = Uri.https('prepa-stat.vercel.app', '/api/auth/login');
    http.Response response = await http.post(url, body: {"email": email, "password": password, "remember": remember.toString()});
    print(response.body);
    return json.decode(response.body);
  }

  static Future<Map> signup(String email, String password, String username, String confirmPassword, String filiere) async {
    Uri url = Uri.https('prepa-stat.vercel.app', '/api/auth/register');
    http.Response response = await http.post(url, body: {
      "name": username,
      "email": email,
      "filiere": filiere,
      "password1": password,
      "password2": confirmPassword,
      //"remember": remember.toString()
    });
    print(response.body);
    return json.decode(response.body);
  }


}

