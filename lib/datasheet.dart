import 'package:flutter/material.dart';
import 'package:prepa_app/utils/style.dart';

import 'models/ecole.dart';

class Datasheet extends StatelessWidget {
  final Ecole ecole;
  const Datasheet({Key? key, required this.ecole}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget buildComponent(String name, double? chiffre, bool isUp, bool pourcent) {
      dynamic chiffreString = chiffre;
      if (!pourcent && chiffre != null) {
        chiffreString = chiffre.toInt();
      }
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: Style.boldStyle(14.0)),
            const SizedBox(height: 5.0),
            Text(chiffreString.toString() + (pourcent ? "%" : ""), style: Style.boldStyle(22.0)),
            const SizedBox(height: 5.0),
            Row(
              children: [
                Icon(isUp ? Icons.arrow_drop_up_rounded : Icons.arrow_drop_down_rounded, color: isUp ? Colors.green : Colors.red),
                Text(chiffreString.toString())
              ],
            )
          ],
        ),
      );
    }

    return AlertDialog(
      title: Text(ecole.name),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("✨ Statistiques d'intégration ", style: Style.boldStyle(18.0)),
          const Divider(),
          FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildComponent("Places", ecole.places?.toDouble(), true, false),
                buildComponent("Rang médian", ecole.rangMedian?.toDouble(), false, false),
                buildComponent("Rang moyen", ecole.rangMoyen?.toDouble(), true, false),
              ],
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildComponent("Cinq demis", ecole.integres_5_2, true, true),
              buildComponent("Filles", ecole.integresFilles, false, true),
            ],
          ),
          const Divider(),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("🏅 Classement", style: Style.boldStyle(18.0)),
                const VerticalDivider(),
                Row(
                  children: [
                    Text(ecole.classement.toString(), style: Style.boldStyle(25.0)),
                    const Text("/200", style: TextStyle(fontSize: 13, color: Colors.grey, fontWeight: FontWeight.bold)),
                  ],
                ),
              ]
            ),
          ),
          const SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? MaterialStateProperty.all<Color>(Colors.black12)
                  : MaterialStateProperty.all<Color>(Colors.blue)
            ),
            child: const Text("🚀 Ajouter aux favoris" ),
          )
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("FERMER"))
      ],
    );
  }
}
