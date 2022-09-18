import 'package:flutter/material.dart';
import 'package:prepa_app/utils/my_shared_preferences.dart';

import '../home.dart';
import '../utils/navigation_service.dart';

class Deconnection extends StatelessWidget {
  const Deconnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          await MySharedPreferences.deconnexion();
          Navigator.of(NavigationService.getContext()).pushReplacement(MaterialPageRoute(builder: (context) => const Home(index: 4,)));
        },
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
        child: const Text("SE DECONNECTER")
      ),
    );
  }
}
