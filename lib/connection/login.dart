import 'package:flutter/material.dart';
import 'package:prepa_app/database.dart';
import 'package:prepa_app/home.dart';
import 'package:prepa_app/utils/my_shared_preferences.dart';
import 'package:prepa_app/utils/screens_manager.dart';

//import 'package:email_validator/email_validator.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool emailValidator = true;
  bool passwordValidator = true;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("SE CONNECTER", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (!emailValidator) {
                    return "Email invalide";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "Entrez votre email",
                  icon: Icon(Icons.email)
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (!passwordValidator) {
                    return "Mot de passe incorrect";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Mot de passe",
                  hintText: "Entrez votre mot de passe",
                  icon: Icon(Icons.password)
                ),
                obscureText: true,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Checkbox(value: false, onChanged: null),
                      Text("Souvenez-vous de moi")
                    ],
                  ),
                  TextButton(
                    child: const Text("Mot de passe oublié"),
                    onPressed: () {}
                  )
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text("Connexion"),
                  onPressed: () async {
                    String username = await DBConnection.validator(_emailController.text, _passwordController.text);
                    if (username == "Email non enregistréeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee") {
                      emailValidator = false;
                      passwordValidator = true;
                    } else {
                      emailValidator = true;
                      if (username == "Mot de passe incorrecteeeeeeeeeeeeeeeeeeeeeeeeeeee") {
                        passwordValidator = false;
                      } else {
                        passwordValidator = true;
                      }
                    }
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Connection succeful")));
                      await MySharedPreferences.connexion(username);
                    }
                  }
                )
              ),
              Container(
                width: double.infinity,
                color: Colors.transparent,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: const Text("Connexion avec Google", style: TextStyle(color: Colors.black))
                )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Pas de compte ?"),
                  TextButton(
                    child: const Text("S'enregistrer"),
                    onPressed: () {
                      ScreensManager.toggleLoginScreen();
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Home(index: 4,)));
                    }
                  )
                ],
              )
            ],
          )
        )
      ),
    );
  }
}
