import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prepa_app/simulator/stepper_bar.dart';

class Simulator extends StatefulWidget {
  const Simulator({Key? key}) : super(key: key);

  @override
  State<Simulator> createState() => _SimulatorState();
}

class _SimulatorState extends State<Simulator> {

  int activeStep = 0;
  double result = 0;

  final concoursList = ["X-ENS","Mines Ponts","Centrale","CCINP","E3A"];
  final filiereList = ["MP", "PC", "PSI", "PT"];

  final List<TableRow> columsRow = [const TableRow(children: [
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: Text("Epreuve")),
    ),
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: Text("Coef.")),
    ),
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: Text("Note")),
    )
  ])];

  var matieresTest = ["Mathématiques 1 :", "Physique-Chimie :", "Mathématiques 2 :", "Physique :", "Français-Philo :",
  "LV1 :", "LV2 :", "Option Info ou SI :"];
  var coeffTest = [12, 7, 12, 7, 9, 4, 2, 7];

  final List<TextEditingController> _controller = [];

  late String? _selectedConcours = concoursList[0];
  late String? _selectedFiliere = filiereList[0];
  bool? isRedoublant = false;
  bool? isLangue = false;
  double barreAdmissible = 10.0;

  void resetController() {
    for (int i = 0 ; i < _controller.length ; i++) {
      _controller[i].value = TextEditingValue(
        text: "",
        selection: TextSelection.fromPosition(
          const TextPosition(offset: 0),
        )
      );
    }
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0 ; i < matieresTest.length ; i++) {
      _controller.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    super.dispose();
    for (int i = 0 ; i < _controller.length ; i++) {
      _controller[i].dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight, maxHeight: double.infinity),
          child: IntrinsicHeight(
            child: Column(
              children: [
                StepperBar(step: activeStep),
                Expanded(
                  child: activeStep == 0 ? pageOne() : (activeStep == 1 ? pageTwo() : pageThree()),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget pageOne() {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.69,
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color.fromRGBO(240, 45, 81, 1), Color.fromRGBO(242, 114, 26, 1)]
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const Text("Renseignez vos informations", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              Padding( // CHOISIR CONCOURS
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: const BorderRadius.all(Radius.circular(20))
                  ),
                  child: Column(
                      children: concoursList.map((e) => RadioListTile(
                        title: Text(e, style: const TextStyle(fontSize: 15)),
                        value: e,
                        groupValue: _selectedConcours,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedConcours = value;
                          });
                        },
                        activeColor: Theme.of(context).primaryColor,
                        visualDensity: const VisualDensity(vertical: -4),
                        dense: true,
                      )).toList()
                  ),
                ),
              ),
              Padding( // CHOISIR FILIERE
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: const BorderRadius.all(Radius.circular(20))
                  ),
                  child: Column(
                      children: filiereList.map((e) => RadioListTile(
                        title: Text(e, style: const TextStyle(fontSize: 15)),
                        value: e,
                        groupValue: _selectedFiliere,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedFiliere = value;
                          });
                        },
                        activeColor: Theme.of(context).primaryColor,
                        visualDensity: const VisualDensity(vertical: -4),
                        dense: true,
                      )).toList()
                  ),
                ),
              ),
              Padding( // CHOISIR OPTIONS
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: const BorderRadius.all(Radius.circular(20))
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              activeColor: Colors.black,
                              value: isRedoublant,
                              onChanged: (bool? value) {
                                setState(() {
                                  isRedoublant = value;
                                });
                              },
                            ),
                            const Text("5/2")
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              activeColor: Colors.black,
                              value: isLangue,
                              onChanged: (bool? value) {
                                setState(() {
                                  isLangue = value;
                                });
                              },
                            ),
                            const Text("LV2")
                          ],
                        )
                      ],
                    ),
                  )
              ),
              GestureDetector(
                onTap: () async {
                  await setSimulator();
                  setState(() {
                    activeStep++;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: FittedBox(
                          child: Row(
                            children: const [
                              Text("Saisir les notes", style: TextStyle(color: Colors.black),),
                              Icon(Icons.arrow_forward, color: Colors.black)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget pageTwo() {
    return Center(
      child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color.fromRGBO(240, 45, 81, 1), Color.fromRGBO(242, 114, 26, 1)]
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Rentrez vos notes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  Table(
                    border: TableBorder.all(),
                    columnWidths: const <int, TableColumnWidth>{
                      0: FlexColumnWidth(3),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(1)
                    },
                    children: columsRow + List<TableRow>.generate(
                        matieresTest.length,
                        (index) => TableRow(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(matieresTest[index]),
                          ),
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.fill,
                            child: Center(child: Text(coeffTest[index].toString()))
                          ),
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.fill,
                            child: Container(
                              color: Colors.white,
                              child: Center(
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: _controller[index],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 15, color: Colors.black),
                                  onChanged: (String value) {
                                    String lastValue = value.substring(0, value.length - 1);
                                    if (int.parse(value).isNaN) {
                                      _controller[index].text = lastValue;
                                    } else if (int.parse(value) < 0 || int.parse(value) > 20) {
                                      _controller[index].text = lastValue;
                                    } else if (value.startsWith("0")) {
                                      _controller[index].text = int.parse(value).toString();
                                    } else {
                                      _controller[index].text = value;
                                    }
                                    _controller[index].selection = TextSelection.fromPosition(
                                      TextPosition(offset: _controller[index].text.length),
                                    );
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "10",
                                    hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                                    border: InputBorder.none,
                                    fillColor: Colors.white,
                                    filled: true,
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(8),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ])
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              activeStep--;
                              resetController();
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(7)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FittedBox(
                                  child: Row(
                                    children: const [
                                      Icon(Icons.arrow_back, color: Colors.black),
                                      Text("Retour", style: TextStyle(color: Colors.black))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              bool validator = true;
                              for (int i = 0 ; i < _controller.length ; i++) {
                                if (_controller[i].text == "") validator = true;
                              }
                              if (validator) {
                                activeStep++;
                                int coeff = 0;
                                result = 0;
                                for (int i = 0 ; i < matieresTest.length ; i++) {
                                  result += coeffTest[i] ;//* int.parse(_controller[i].text);
                                  coeff += coeffTest[i];
                                }
                                result /= coeff;
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Vous devez renseigner toute les notes."))
                                );
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(7)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FittedBox(
                                  child: Row(
                                    children: const [
                                      Text("Résultat", style: TextStyle(color: Colors.black)),
                                      Icon(Icons.arrow_forward, color: Colors.black)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

  Widget pageThree() {
    return Center(
      child: FittedBox(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.75,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color.fromRGBO(240, 45, 81, 1), Color.fromRGBO(242, 114, 26, 1)]
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text("${result > barreAdmissible ? "🎊" : "😭"} Résultat", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                ),
                Text("• Votre moyenne est de $result", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: result > barreAdmissible ? const Text("Félicitation vous êtes admissible !", style: TextStyle(fontSize: 16)) : const Text("Dommage, vous n'êtes pas admissible !\n💪 Ne baisse pas les bras, tu peux le faire !", style: TextStyle(fontSize: 16)),
                ),
                const Text("• Récapitulatif", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Filière : ${_selectedFiliere!}\nConcours : ${_selectedConcours!}\n5/2 : ${isRedoublant == true ? "Oui" : "Non"}\nLV2 : ${isLangue == true ? "Oui" : "Non"}\nBarre d'admissibilité : $barreAdmissible", style: const TextStyle(fontSize: 16)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            activeStep--;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FittedBox(
                              child: Row(
                                children: const [
                                  Icon(Icons.arrow_back, color: Colors.black),
                                  Text("Retour", style: TextStyle(color: Colors.black))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            activeStep = 0;
                            isLangue = false;
                            isRedoublant = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FittedBox(
                              child: Row(
                                children: const [
                                  Text("Recommencer", style: TextStyle(color: Colors.black),),
                                  Icon(Icons.arrow_forward, color: Colors.black)
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }

  Future<void> setSimulator() async {
    final String response = await rootBundle.loadString('data/simulator.json');
    final data = await json.decode(response);
    try{
      Map exam = data.firstWhere((exam) => exam["concours"] == _selectedConcours &&  exam["filiere"] == _selectedFiliere);
      matieresTest = [];
      coeffTest = [];
      exam["epreuves"].forEach((e) {
        if (!(e["nom"] == "LV2" && !isLangue!)) {
          matieresTest.add(e["nom"]);
          coeffTest.add(e["coef"]);
        }
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("An error has occurred")));
    }
  }
}
