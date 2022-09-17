import 'package:flutter/material.dart';
import 'package:prepa_app/utils/my_shared_preferences.dart';

class Deconnection extends StatelessWidget {
  const Deconnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => MySharedPreferences.deconnexion(),
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
        child: const Text("SE DECONNECTER")
      ),
    );
  }
}
