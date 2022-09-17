import 'package:flutter/material.dart';
import 'package:prepa_app/connection/deconnection.dart';
import 'package:prepa_app/connection/login.dart';
import 'package:prepa_app/connection/sign_up.dart';
import 'package:prepa_app/utils/my_shared_preferences.dart';
import 'package:prepa_app/utils/screens_manager.dart';

class Connection extends StatefulWidget {
  const Connection({Key? key}) : super(key: key);

  @override
  State<Connection> createState() => _ConnectionState();
}

class _ConnectionState extends State<Connection> {
  @override
  Widget build(BuildContext context) {
    return MySharedPreferences.isConnected ? const Deconnection() : (ScreensManager.loginScreen ? const Login() : const SignUp());
  }
}

