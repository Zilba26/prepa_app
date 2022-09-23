import 'package:flutter/material.dart';
import 'package:prepa_app/models/concours.dart';
import 'package:prepa_app/models/filiere.dart';
import 'package:prepa_app/utils/navigation_service.dart';

class Utils {

  static dynamic getByAdaptiveTheme({required dynamic light, required dynamic dark}) {
    return Theme.of(NavigationService.getContext()).brightness == Brightness.light ? light : dark;
  }

  static Concours getConcours(String concours) {
    switch (concours.toLowerCase()) {
      case "e3a":
        return Concours.e3a;
      case "ccp":
        return Concours.ccp;
      case "mines":
        return Concours.mines;
      case "ens":
        return Concours.ens;
      case "x":
        return Concours.x;
      case "centrale":
        return Concours.centrale;
      default:
        return Concours.other;
    }
  }

  static Concours getConcoursForDatabase(String concours) {
    switch (concours) {
      case "Concours Ecole Polytechnique":
        return Concours.x;
      case "Banque Ens":
        return Concours.ens;
      case "Banque Centrale-Supelec":
        return Concours.centrale;
      case "Concours Commun Mines-Ponts":
        return Concours.mines;
      case "Concours Commun Inp":
        return Concours.ccp;
      case "Banque Epreuves Ccinp Inter-Filière":
        return Concours.ccp;
      case "Banque Epreuves Ccinp":
        return Concours.ccp;
      case "Concours Commun Tpe":
        return Concours.mines;
      case "Concours Mines - Télécom":
        return Concours.mines;
      case "Concours Polytech Inter-Filière":
        return Concours.e3a;
      case "Autres Écoles E3A":
        return Concours.e3a;
      case "Fesic":
        return Concours.e3a;
      case "Groupe Insa":
        return Concours.other;
      case "Groupe Insa Inter-Filière":
        return Concours.other;
      case "Cesi":
        return Concours.other;
      case "Epita":
        return Concours.other;
      case "Avenir Prépas":
        return Concours.e3a;
      case "Puissance Alpha":
        return Concours.e3a;
      case "Concours Ens De Cachan":
        return Concours.ens;
      case "Concours Commun Ensam":
        return Concours.other;
      case "Centrale-Supelec":
        return Concours.centrale;
      case "Concours Polytech":
        return Concours.e3a;
      case "Banque Epreuves Ccinp  Inter-Filière":
        return Concours.ccp;
      case "Banque Ens Cachan/Ec. Polytech":
        return Concours.other;
      case "Ccinp : Ecoles Recrutant Sur Le Concours Physique":
        return Concours.ccp;
      case "Ccinp : Ecoles Recrutant Sur Le Concours Chimie":
        return Concours.ccp;
      case "Autres Ecoles":
        return Concours.other;
      default:
        print("Concours non reconnu: $concours");
        return Concours.other;
    }
  }

  static String getConcoursName(Concours concours) {
    switch (concours) {
      case Concours.x:
        return "X";
      case Concours.ens:
        return "ENS";
      case Concours.centrale:
        return "Centrale";
      case Concours.mines:
        return "Mines";
      case Concours.ccp:
        return "CCP";
      case Concours.e3a:
        return "E3A";
      default:
        return "Autres";
    }
  }

  static Filiere getFiliere(String filiere) {
    filiere = filiere.toLowerCase();
    if (filiere.contains("psi")) {
      return Filiere.psi;
    } else if (filiere.contains("pc")) {
      return Filiere.pc;
    } else if (filiere.contains("pt")) {
      return Filiere.pt;
    } else {
      return Filiere.mp;
    }
  }

  static String getFiliereName(Filiere filiere) {
    switch (filiere) {
      case Filiere.mp:
        return "MP";
      case Filiere.pc:
        return "PC";
      case Filiere.pt:
        return "PT";
      case Filiere.psi:
        return "PSI";
    }
  }
}