import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:prepa_app/models/filiere.dart';

import '../datasheet.dart';
import '../models/concours.dart';
import '../models/ecole.dart';
import '../utils/database.dart';
import '../utils/my_shared_preferences.dart';

class Stats extends StatefulWidget {
  final Concours concours;
  final Filiere filiere;

  const Stats({Key? key, required this.concours, required this.filiere}) : super(key: key);

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {

  bool _sortAscending = true;
  int? _sortColumnIndex;

  late List<Ecole> schoolList = DBConnection.getSchools(2021, widget.concours, widget.filiere);

  void sort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
      schoolList.sort((a, b) {
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

  String convertNbToString(int? nb) {
    if (nb == -1 || nb == null) {
      return "-";
    }
    return nb.toString();
  }

  Widget _buildHeadingCell({required String label, required int columnIndex, bool isSort = true}) {
    return InkWell(
      onTap: () {
        if(isSort) sort(columnIndex, !_sortAscending);
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
            Opacity(
              opacity: _sortColumnIndex == columnIndex ? 1 : 0,
              child: Icon(
                _sortAscending ? Icons.arrow_upward : Icons.arrow_downward,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (schoolList[0].filiere != widget.filiere || schoolList[0].concours != widget.concours) {
      schoolList = DBConnection.getSchools(2021, widget.concours, widget.filiere);
    }
    return Column(
      children: [
        SizedBox(
          //height: 56.0,
          child: Row(
            children: [
              Expanded(
                flex: 120,
                child: _buildHeadingCell(label: "ECOLES", columnIndex: 0)
              ),
              Expanded(
                flex: 67,
                child: _buildHeadingCell(label: "INSCRITS", columnIndex: 1)
              ),
              Expanded(
                flex: 67,
                child: _buildHeadingCell(label: "ADMISSIBLES", columnIndex: 2)
              ),
              Expanded(
                flex: 67,
                child: _buildHeadingCell(label: "INTEGRES", columnIndex: 3)
              ),
              Expanded(
                flex: 67,
                child: _buildHeadingCell(label: "PLACES", columnIndex: 4)
              ),
              if (MySharedPreferences.isConnected) Expanded(
                flex: 67,
                child: _buildHeadingCell(label: "FAVORIS", columnIndex: 5, isSort: false)
              )
            ],
          ),
        ),
        Expanded(
          child: DataTable2(
            columnSpacing: 4,
            horizontalMargin: 8,
            headingRowHeight: 0,
            minWidth: MediaQuery.of(context).size.width,
            sortColumnIndex: _sortColumnIndex,
            sortAscending: _sortAscending,
            columns: [
              const DataColumn2(label: Text("ECOLES", style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)), numeric: false, size: ColumnSize.L, ),
              const DataColumn2(label: Text("INSCRITS", style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)), numeric: true, size: ColumnSize.S, ),
              const DataColumn2(label: Text("ADMISSIBLES", style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, backgroundColor: Colors.red)), numeric: true, size: ColumnSize.S, ),
              const DataColumn2(label: Text("INTEGRES", style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)), numeric: true, size: ColumnSize.S, ),
              const DataColumn2(label: Text("PLACES", style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)), numeric: true, size: ColumnSize.S, ),
              if (MySharedPreferences.isConnected) const DataColumn2(label: Text("FAVORIS", style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)), numeric: false, size: ColumnSize.S)
            ],
            rows: schoolList.map((Ecole ecole) {
              return DataRow2(
                onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => Datasheet(ecole: ecole),
                ),
                cells: [
                  DataCell(Text(ecole.name, maxLines: 3, style: const TextStyle(fontSize: 12, overflow: TextOverflow.ellipsis))),
                  DataCell(Center(child: Text(convertNbToString(ecole.inscrits)))),
                  DataCell(Center(child: Text(convertNbToString(ecole.admissibles)))),
                  DataCell(Center(child: Text(convertNbToString(ecole.integres)))),
                  DataCell(Center(child: Text(convertNbToString(ecole.places)))),
                  if (MySharedPreferences.isConnected) const DataCell(Center(child: Icon(Icons.favorite, color: Colors.red)))
                ]
              );
            }).toList()
          ),
        ),
      ],
    );
  }
}
