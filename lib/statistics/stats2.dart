import 'package:flutter/material.dart';
import 'package:prepa_app/statistics/stats.dart';

class Stats2 extends StatefulWidget {
  const Stats2({Key? key}) : super(key: key);

  @override
  State<Stats2> createState() => _Stats2State();
}

class _Stats2State extends State<Stats2> with TickerProviderStateMixin {

  late TabController _concoursTabController;
  late TabController _ecoleTabController;

  final List<Tab> concoursTab = <Tab>[
    const Tab(text: "MP"),
    const Tab(text: "PC"),
    const Tab(text: "PT"),
    const Tab(text: "PSI")
  ];

  final List<Tab> ecoleTab = <Tab>[
    const Tab(text: "Général"),
    const Tab(text: "X"),
    const Tab(text: "ENS"),
    const Tab(text: "Centrale"),
    const Tab(text: "Mines"),
    const Tab(text: "CCP"),
    const Tab(text: "E3A"),
  ];

  @override
  void initState() {
    _concoursTabController = TabController(length: concoursTab.length, vsync: this);
    _concoursTabController.addListener(() {
      setState(() {});
    });
    _ecoleTabController = TabController(length: ecoleTab.length, vsync: this);
    _ecoleTabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _concoursTabController.dispose();
    _ecoleTabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          indicatorColor: const Color.fromRGBO(241, 79, 53, 1),
          controller: _concoursTabController,
          tabs: concoursTab
        ),
        const SizedBox(height: 10),
        TabBar(
          isScrollable: true,
          labelColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
          indicator: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color.fromRGBO(240, 45, 81, 1), Color.fromRGBO(242, 114, 26, 1)]
            )
          ),
          controller: _ecoleTabController,
          tabs: ecoleTab
        ),
        Expanded(
          child: Stats(
            concours: concoursTab[_concoursTabController.index].text!,
            ecole: ecoleTab[_ecoleTabController.index].text!,
          ),
        ),
      ],
    );
  }
}
