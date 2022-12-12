import 'package:flutter/material.dart';
import 'package:prepa_app/connection/deconnection.dart';
import 'package:prepa_app/connection/login.dart';
import 'package:prepa_app/connection/sign_up.dart';
import 'package:prepa_app/utils/my_shared_preferences.dart';

class Connection extends StatefulWidget {
  const Connection({Key? key}) : super(key: key);

  @override
  State<Connection> createState() => _ConnectionState();
}

class _ConnectionState extends State<Connection> {

  final PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return MySharedPreferences.isConnected ? const Deconnection() :
        PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _controller,
          children: [
            Login(controller: _controller,),
            SignUp(controller: _controller,),
          ],
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

