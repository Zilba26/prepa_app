import 'package:flutter/material.dart';
import 'package:prepa_app/models/profile.dart';
import 'package:prepa_app/utils/database.dart';
import 'package:prepa_app/home.dart';
import 'package:prepa_app/utils/my_shared_preferences.dart';

import '../utils/navigation_service.dart';

//import 'package:email_validator/email_validator.dart';

class Login extends StatefulWidget {
  const Login({Key? key, required this.controller}) : super(key: key);

  final PageController controller;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool emailValidator = true;
  bool passwordValidator = true;

  final _formKey = GlobalKey<FormState>();

  bool remember = true;

  bool fetchLoading = false;

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
                    children: [
                      Checkbox(
                        value: remember,
                        onChanged: (value) {
                          setState(() {
                            remember = value!;
                          });
                        },
                      ),
                      const Text("Souvenez-vous de moi")
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
                  onPressed: () async {
                    if (fetchLoading) return;
                    setState(() {
                      fetchLoading = true;
                    });
                    Map response = await DBConnection.login(_emailController.text, _passwordController.text, remember);
                    if (response["message"] == "Error fetching user." || _emailController.text.isEmpty) {
                      emailValidator = false;
                      passwordValidator = true;
                    } else {
                      emailValidator = true;
                      if (response["message"] == "Password is incorrect." || _passwordController.text.isEmpty) {
                        passwordValidator = false;
                      } else {
                        passwordValidator = true;
                      }
                    }
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(NavigationService.getContext()).showSnackBar(const SnackBar(content: Text("Connection succeful")));
                      Profile profile = Profile(id: response["user"]["_id"], username: response["user"]["name"], email: response["user"]["email"]);
                      await MySharedPreferences.connexion(profile, remember);
                      Navigator.of(NavigationService.getContext()).pushReplacement(MaterialPageRoute(builder: (context) => const Home(index: 4,)));
                    }
                    setState(() {
                      fetchLoading = false;
                    });
                  },
                  child: fetchLoading ? const SizedBox(height: 25, width: 25, child: CircularProgressIndicator(color: Colors.white)) : const Text("Connexion")
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
                      widget.controller.jumpToPage(1);
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
