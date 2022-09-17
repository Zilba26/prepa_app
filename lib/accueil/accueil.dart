import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../home.dart';

class Accueil extends StatelessWidget {
  const Accueil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          const Pad(
            child: Text("PrépaStat", style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30
            )),
          ),
          const Pad(
            child: Text("Construisons ensemble votre avenir, intégrez l'école d'ingénieur de vos rêves !", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
            )),
          ),
          const Pad(child: Text("Lorem ipsum dolor sit amet consectetur adipisicing elit. Facere obcaecati quos iste soluta voluptas dolorum voluptate autem vel nihil ipsa amet, voluptatem nesciunt nisi debitis, doloribus assumenda. Consequatur, harum rerum?")),
          Pad(
            child: Container(
              height: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[Colors.orange, Colors.red]
                )
              ),
              child: Center(child: GestureDetector(
                onTap: () {
                  //DBConnection.addUser("Basile", "Lebaudy");
                },
                child: const Text("EN SAVOIR PLUS", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
              ))
            ),
          ),
          Pad(
            child: Container(
              height: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: Colors.redAccent)
              ),
              child: Center(child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Home(index: 4)));
                },
                child: const Text("S'ENREGISTRER", style: TextStyle(fontWeight: FontWeight.bold))
              ))
            ),
          ),
          Pad(child: Align(alignment: Alignment.center, child: Image.asset("assets/images/femmeAccueil.png", height: 200.0))),
          const Pad(child: Align(alignment: Alignment.center ,child: Text(
            "Nos objectifs",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)
          ))),
          const Objectif(
            icon: "assets/images/folder.svg",
            titre: "Facilité l'accès à l'information",
            text: "Lorem ipsum, dolor sit amet consectetur adipisicing elit. Sint voluptate suscipit in, possimus dicta nemo quisquam cumque. Culpaminus, cum sequi vero quisquam, assumenda accusantium recusandae expedita fuga itaque porro!"
          ),
          const SizedBox(height: 30.0),
          const Objectif(
              icon: "assets/images/couvreChef.svg",
              titre: "Accompagner les étudiants",
              text: "Lorem ipsum, dolor sit amet consectetur adipisicing elit. Sint voluptate suscipit in, possimus dicta nemo quisquam cumque. Culpaminus, cum sequi vero quisquam, assumenda accusantium recusandae expedita fuga itaque porro!"
          ),
          const SizedBox(height: 30.0),
          const Objectif(
              icon: "assets/images/men.svg",
              titre: "Motiver les étudiants",
              text: "Lorem ipsum, dolor sit amet consectetur adipisicing elit. Sint voluptate suscipit in, possimus dicta nemo quisquam cumque. Culpaminus, cum sequi vero quisquam, assumenda accusantium recusandae expedita fuga itaque porro!"
          ),
          const SizedBox(height: 50.0),
          const Raccourci(
            image: "assets/images/raccourci3.svg",
            title: "Comparez les écoles d'ingénieurs",
            text: "Lorem ipsum, dolor sit amet consectetur adipisicing elit. Sint voluptate suscipit in, possimus dicta nemo quisquam cumque. Culpaminus, cum sequi vero quisquam, assumenda accusantium recusandae expedita fuga itaque porro!",
            textButton: "Classements",
            pageOfButton: ""
          ),
          const SizedBox(height: 30.0),
          const Raccourci(
              image: "assets/images/raccourci2.svg",
              title: "Simulez votre admissibilité",
              text: "Lorem ipsum, dolor sit amet consectetur adipisicing elit. Sint voluptate suscipit in, possimus dicta nemo quisquam cumque. Culpaminus, cum sequi vero quisquam, assumenda accusantium recusandae expedita fuga itaque porro!",
              textButton: "Simulateur",
              pageOfButton: ""
          ),
          const SizedBox(height: 30.0),
          const Raccourci(
              image: "assets/images/raccourci3.svg",
              title: "Trouvez l'école qui vous correspond",
              text: "Lorem ipsum, dolor sit amet consectetur adipisicing elit. Sint voluptate suscipit in, possimus dicta nemo quisquam cumque. Culpaminus, cum sequi vero quisquam, assumenda accusantium recusandae expedita fuga itaque porro!",
              textButton: "Statistiques",
              pageOfButton: ""
          ),
        ],
      ),
    );
  }
}

class Pad extends StatelessWidget {
  final Widget child;
  const Pad({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 12.0),
      child: child
    );
  }
}

class CenterAlign extends StatelessWidget {
  final Widget child;
  const CenterAlign({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: child
    );
  }
}

class Objectif extends StatelessWidget {
  final String icon;
  final String titre;
  final String text;
  const Objectif({Key? key, required this.icon, required this.titre, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Pad(child: CenterAlign(child: SvgPicture.asset(icon))),
        Pad(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(titre, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
        )),
        Pad(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(text)
        ))
      ],
    );
  }
}

class Raccourci extends StatelessWidget {
  final String image;
  final String title;
  final String text;
  final String textButton;
  final String pageOfButton;
  const Raccourci({Key? key, required this.title, required this.text, required this.textButton, required this.pageOfButton, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Pad(
      child: Column(
        children: [
          Pad(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold))),
          Pad(child: Text(text)),
          Pad(
            child: Container(
              height: 50.0,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[Colors.orangeAccent, Colors.orange]
                ),
                borderRadius: BorderRadius.circular(6.0)
              ),
              child: Center(
                child: GestureDetector(
                  onTap: null,
                  child: Text(textButton, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ),
          SvgPicture.asset(image, height: 150.0,)
        ],
      ),
    );
  }
}



