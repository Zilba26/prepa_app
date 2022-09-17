class Ecole {
  String name;
  double place;
  int classement;
  double rangMedian;
  double rangMoyen;
  double pourcentage5_2;
  double pourcentageFilles;
  int inscrits;
  int admissibles;
  int integres;
  int places;
  Ecole(this.name, this.place, this.classement, this.rangMedian, this.rangMoyen, this.pourcentage5_2,
      this.pourcentageFilles, this.inscrits, this.admissibles, this.integres, this.places);
}

class EcoleStatsTest {
  String name;
  int inscrits;
  int admissibles;
  int integres;
  int places;

  EcoleStatsTest(this.name, this.inscrits, this.admissibles, this.integres, this.places);

  int getValue(int? sortColumnIndex) {
    switch (sortColumnIndex) {
      case 1:
        return inscrits;
      case 2:
        return admissibles;
      case 3:
        return integres;
      case 4:
        return places;
      default:
        return inscrits;
    }
  }
}