import 'package:flutter/material.dart';
import 'package:prepa_app/accueil/accueil.dart';
import 'package:prepa_app/utils/my_shared_preferences.dart';


class SetAccueil extends StatelessWidget {
  const SetAccueil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !MySharedPreferences.isConnected ? const Accueil() : Center(child: Text("Bienvenue ${MySharedPreferences.username}"));
  }
}
