import 'package:prepa_app/models/concours.dart';
import 'package:prepa_app/models/filiere.dart';
import 'package:prepa_app/utils/utils.dart';

class Ecole {
  Concours concours;
  String name;

  int? inscrits;
  double? inscritsFilles; // en %
  double? inscrits_5_2; // en %

  int? admissibles;
  double? admissiblesFilles; // en %
  double? admissibles_5_2; // en %

  int? classes;
  double? classesFilles; // en %
  double? classes_5_2; // en %

  int? integres;
  double? integresFilles; // en %
  double? integres_5_2; // en %

  int? rangMedian;
  int? rangMoyen;

  int? places;
  int annee;
  Filiere filiere;

  int classement = 12; //TODO: remove this


  Ecole.fromMap(Map<dynamic, dynamic> map) :
    concours = Utils.getConcoursForDatabase(map['concours']),
    name = map['ecole'],
    inscrits = map['inscrits_nb'],
    inscritsFilles = getDoubleValue(map['inscrits_cinq_demi']),
    inscrits_5_2 = getDoubleValue(map['inscrits_cinq_demi']),
    admissibles = map['admissibles_nb'],
    admissiblesFilles = getDoubleValue(map['admissibles_filles']),
    admissibles_5_2 = getDoubleValue(map['admissibles_cinq_demi']),
    classes = map['classes_nb'],
    classesFilles = getDoubleValue(map['classes_filles']),
    classes_5_2 = getDoubleValue(map['classes_cinq_demi']),
    integres = map['integres_nb'],
    integresFilles = getDoubleValue(map['integres_filles']),
    integres_5_2 = getDoubleValue(map['integres_cinq_demi']),
    rangMedian = map['integres_rg_median'],
    rangMoyen = map['integres_rg_moyen'],
    places = map['places'],
    annee = map['annee'],
    filiere = Utils.getFiliere(map['filiere']);

  int getValue(int? sortColumnIndex) {
    switch (sortColumnIndex) {
      case 1:
        return inscrits ?? -1;
      case 2:
        return admissibles ?? -1;
      case 3:
        return integres ?? -1;
      case 4:
        return places ?? -1;
      default:
        return inscrits ?? -1;
    }
  }
  
  static double? getDoubleValue(dynamic nb) {
    if (nb is int) {
      return nb.toDouble();
    } else {
      return nb;
    }
  }
}