import 'package:flutter/material.dart';
import 'package:prepa_app/database.dart';
import 'package:email_validator/email_validator.dart';
import 'package:prepa_app/utils/my_shared_preferences.dart';
import 'package:prepa_app/utils/screens_manager.dart';

import '../home.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  final _usernameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isVisible = true;
  bool isVisible2 = true;
  bool emailValidator = true;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    _usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text("S'ENREGISTRER", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Merci de rentrer un nom d'utilisateur";
                    }
                    if (value.length > 32) {
                      return "Nom d'utilisateur de 32 caractères maximum";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: "Nom d'utilisateur",
                      hintText: "Entrez votre nom d'utilisateur",
                      icon: Icon(Icons.email)
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (emailValidator) {
                      return "Email déjà enregistré";
                    }
                    if (!EmailValidator.validate(value!)) {
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
                    if (value == null || value.isEmpty) {
                      return "Merci de rentrer un mot de passe";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Mot de passe",
                    hintText: "Entrez votre mot de passe",
                    icon: const Icon(Icons.password),
                    suffixIcon: IconButton(
                      icon: isVisible ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      }
                    )
                  ),
                  obscureText: isVisible,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordConfirmationController,
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return "Merci de bien recopier le mot de passe";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Confirmation du mot de passe",
                    hintText: "Ré-entrez votre mot de passe",
                    icon: const Icon(Icons.password),
                    suffixIcon: IconButton(
                      icon: isVisible2 ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          isVisible2 = !isVisible2;
                        });
                      },
                    )
                  ),
                  obscureText: isVisible2,
                ),
                const SizedBox(height: 12),
                /*Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Checkbox(value: true, onChanged: null),
                        Text("Souvenez-vous de moi")
                      ],
                    ),
                  ],
                ),*/
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Text("Créer un compte"),
                    onPressed: () async {
                      emailValidator = await DBConnection.isRegister(_emailController.text);
                      if (_formKey.currentState!.validate()) {
                        DBConnection.addUser(_usernameController.text, _emailController.text, _passwordController.text);
                        await MySharedPreferences.connexion(_usernameController.text);
                      }
                    }
                  )
                ),
                /*Container(
                    width: double.infinity,
                    color: Colors.transparent,
                    child: ElevatedButton(
                        child: const Text("Connexion avec Google", style: TextStyle(color: Colors.black)),
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        )
                    )
                ),*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Déjà un compte ?"),
                    TextButton(
                        child: const Text("Se connecter"),
                        onPressed: () {
                          ScreensManager.toggleLoginScreen();
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Home(index: 4,)));
                        }
                    )
                  ],
                )
              ],
            )
        ),
      ),
    );
  }
}
