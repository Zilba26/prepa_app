import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:prepa_app/accueil/set_accueil.dart';
import 'package:prepa_app/connection/connection.dart';
import 'package:prepa_app/statistics/stats2.dart';
import 'package:prepa_app/leaderboard/leaderboard.dart';
import 'package:prepa_app/simulator/simulator.dart';
import 'package:prepa_app/utils/my_shared_preferences.dart';

class Home extends StatefulWidget {
  final int index;

  const Home({Key? key, this.index = 0}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final List<Widget> widgets = [const SetAccueil(), const Stats2(), Leaderboard(), const Simulator(), const Connection()];
  late int _currentIndex = widget.index;

  @override
  Widget build(BuildContext context) {

    Widget buildItem(IconData icon, String text, int item) {
      return ListTile(
          title: Text(text),
          leading: Icon(icon),
          onTap: () {
            setState(() {
              Navigator.pop(context);
              _currentIndex = item;
            });
          }
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("PrepaStat"),
        actions: [
          IconButton(
            onPressed: () async {
              if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark) {
                setState(() {
                  AdaptiveTheme.of(context).setLight();
                });
                await MySharedPreferences.setLight();
              } else {
                setState(() {
                  AdaptiveTheme.of(context).setDark();
                });
                await MySharedPreferences.setDark();
              }
            },
            icon: Icon(AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark ? Icons.mode_night : Icons.mode_night_outlined),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Image.asset("assets/images/favicon.ico"),
            ),
            buildItem(Icons.home, "Accueil",0),
            buildItem(Icons.show_chart, "Statistiques",1),
            buildItem(Icons.leaderboard, "Classement",2),
            buildItem(Icons.smart_toy, "Simulateur",3),
            buildItem(Icons.wifi, "Se connecter", 4)
          ],
        ),
      ),
      body: widgets[_currentIndex],
    );
  }
}
