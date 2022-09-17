import 'package:flutter/material.dart';

class Leaderboard extends StatelessWidget {
  Leaderboard({Key? key}) : super(key: key);

  final List<Ecole> ecoles = [
    Ecole("École des mines ParisTech", 5, 5, 5, 5),
    Ecole("ESPCI Paris", 5, 5, 5, 5),
    Ecole("	École Polytechnique - Palaiseau", 5, 4, 5, 5),
    Ecole("CY Tech", 2, 5, 1, 5)
  ];

  final List<Icon> icons = [
    const Icon(Icons.exposure_zero_rounded),
    const Icon(Icons.looks_one_rounded, color: Colors.amber),
    const Icon(Icons.looks_two_rounded, color: Colors.green),
    const Icon(Icons.looks_3_rounded, color: Colors.green),
    const Icon(Icons.looks_4_rounded, color: Colors.teal),
    const Icon(Icons.looks_5_rounded, color: Colors.teal)
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
          itemCount: ecoles.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) { // Première carte d'explication
              return Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: const [
                        Text("Ecoles"),
                        Text("Recherche")
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            const Text("Indicateurs"),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                        content: Text("Moyenne au bac des intégrés"),
                                        duration: Duration(milliseconds: 1000)
                                    ));
                                  },
                                  child: const Icon(Icons.looks_one_rounded)
                                ),
                                GestureDetector(
                                    onTap: () {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                          content: Text("Part d'enseignants-chercheurs"),
                                          duration: Duration(milliseconds: 1000)
                                      ));
                                    },
                                    child: const Icon(Icons.looks_two_rounded)
                                ),
                                GestureDetector(
                                    onTap: () {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                          content: Text("Pourcentage de diplomés pousuivant en thèse"),
                                          duration: Duration(milliseconds: 1000)
                                      ));
                                    },
                                    child: const Icon(Icons.looks_3_rounded)
                                ),
                                GestureDetector(
                                    onTap: () {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                          content: Text("Nombre de doctorants (y compris cotutelles)"),
                                          duration: Duration(milliseconds: 1000)
                                      ));
                                    },
                                    child: const Icon(Icons.looks_4_rounded)
                                ),
                              ],
                            )
                          ],
                        ),
                        const Text("Tot")
                      ],
                    )

                  ],
                ),
              );
            }
            else {   // Cartes des écoles
              return Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(ecoles[index-1].name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          icons[ecoles[index-1].point1],
                          icons[ecoles[index-1].point2],
                          icons[ecoles[index-1].point3],
                          icons[ecoles[index-1].point4],
                          Container(
                              color: Colors.black,
                              //padding: const EdgeInsets.all(2.0),
                              child: Text((ecoles[index-1].point1 + ecoles[index-1].point2 + ecoles[index-1].point3 +
                                  ecoles[index-1].point4).toString(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                          )
                        ],
                      )
                    ],
                  )
              );
            }
          }
        );
      //],
    //);
  }
}

class Ecole {
  String name;
  int point1;
  int point2;
  int point3;
  int point4;

  Ecole(this.name, this.point1, this.point2, this.point3, this.point4);
}