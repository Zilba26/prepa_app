import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../datasheet.dart';
import '../models/ecole.dart';
import '../utils/my_shared_preferences.dart';

class Stats extends StatefulWidget {
  final String concours;
  final String ecole;

  const Stats({Key? key, required this.concours, required this.ecole}) : super(key: key);

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {

  bool _sortAscending = true;
  int? _sortColumnIndex;

  final List<EcoleStatsTest> ecoleList = <EcoleStatsTest>[
    EcoleStatsTest("Chimie Paristech", -1, -1, 0, 2),
    EcoleStatsTest("Ensae Paris", -1, -1, 53, 55),
    EcoleStatsTest("Ensta Paris - Apprentissage", -1, -1, 0, 2),
    EcoleStatsTest("Imt Atlantique", -1, -1, 89, 85),
    EcoleStatsTest("Isae - Supaero Toulouse", -1, -1, 70, 75),
    EcoleStatsTest("Mines De Nancy", -1, -1, 50, 55),
    EcoleStatsTest("Mines Saint-Etienne", -1, -1, 44, 50),
    EcoleStatsTest("Mines Paris", -1, -1, 55, 55),
    EcoleStatsTest("Ponts Paristech", -1, -1, 83, 84),
    EcoleStatsTest("Ponts Paristech", -1, -1, 83, 84),
    EcoleStatsTest("Ponts Paristech", -1, -1, 83, 84),
    EcoleStatsTest("Ponts Paristech", -1, -1, 83, 84),
    EcoleStatsTest("Ponts Paristech", -1, -1, 83, 84),
    EcoleStatsTest("Ponts Paristech", -1, -1, 83, 84),
    EcoleStatsTest("Ponts Paristech", -1, -1, 83, 84),
  ];

  void sort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
      ecoleList.sort((a, b) {
        if (_sortColumnIndex == 0) {
          return ascending
              ? a.name.compareTo(b.name)
              : b.name.compareTo(a.name);
        }
        int aValue = a.getValue(_sortColumnIndex);
        int bValue = b.getValue(_sortColumnIndex);
        if (_sortAscending) {
          return aValue - bValue;
        } else {
          return bValue - aValue;
        }
      });
    });
  }

  String convertNbToString(int nb) {
    if (nb == -1) {
      return "-";
    }
    return nb.toString();
  }

  @override
  Widget build(BuildContext context) {
    return DataTable2(
        columnSpacing: 12,
        horizontalMargin: 12,
        minWidth: MediaQuery.of(context).size.width,
        sortColumnIndex: _sortColumnIndex,
        sortAscending: _sortAscending,
        columns: [
          DataColumn2(label: const Text("ECOLES", style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)), numeric: false, size: ColumnSize.L, onSort: (columnIndex, ascending) => sort(columnIndex, ascending)),
          DataColumn2(label: const Text("INSCRITS", style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)), numeric: true, size: ColumnSize.S, onSort: (columnIndex, ascending) => sort(columnIndex, ascending)),
          DataColumn2(label: const Text("ADMISSIBLES", style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)), numeric: true, size: ColumnSize.S, onSort: (columnIndex, ascending) => sort(columnIndex, ascending)),
          DataColumn2(label: const Text("INTEGRES", style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)), numeric: true, size: ColumnSize.S, onSort: (columnIndex, ascending) => sort(columnIndex, ascending)),
          DataColumn2(label: const Text("PLACES", style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)), numeric: true, size: ColumnSize.S, onSort: (columnIndex, ascending) => sort(columnIndex, ascending)),
          if (MySharedPreferences.isConnected) const DataColumn2(label: Text("FAVORIS", style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)), numeric: false, size: ColumnSize.S)
        ],
        rows: ecoleList.map((EcoleStatsTest ecole) {
          return DataRow2(
              onTap: () => showDialog(
                context: context,
                builder: (BuildContext context) => Datasheet(ecole: Ecole(ecole.name, 105, 5, 81, 81, 10.5, 8.6,
                    ecole.inscrits, ecole.admissibles, ecole.integres, ecole.places)),
              ),
              cells: [
                DataCell(Text(ecole.name, style: const TextStyle(fontSize: 12))),
                DataCell(Center(child: Text(convertNbToString(ecole.inscrits)))),
                DataCell(Center(child: Text(convertNbToString(ecole.admissibles)))),
                DataCell(Center(child: Text(convertNbToString(ecole.integres)))),
                DataCell(Center(child: Text(convertNbToString(ecole.places)))),
                if (MySharedPreferences.isConnected) const DataCell(Center(child: Icon(Icons.favorite, color: Colors.red)))
              ]
          );
        }).toList()
    );
  }
}