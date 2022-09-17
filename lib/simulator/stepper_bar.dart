import 'package:flutter/material.dart';

class StepperBar extends StatelessWidget {
  final int step;
  const StepperBar({Key? key, required this.step}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthQuery = MediaQuery.of(context).size.width * 0.35;
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 30.0),
        //color: Colors.blue,
        child: Stack(
          children: [
            line(widthQuery),
            icons()
          ],
        ),
      ),
    );
  }

  Widget line(double width) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.5, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          step == 2 ? Row(children: [coloredContainer(width), coloredContainer(width)])
              : (step == 0 ? Row(children: [whiteContainer(width), whiteContainer(width)])
              : Row(children: [coloredContainer(width), whiteContainer(width)])),
        ],
      ),
    );
  }

  Widget icons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        icon(Icons.info_outline),
        icon(const IconData(0xf0653, fontFamily: 'MaterialIcons')),
        icon(Icons.emoji_events_outlined)
      ],
    );
  }

  Widget whiteContainer(double width) {
    return Container(
      color: Colors.white,
      height: 18,
      width: width,
    );
  }

  Widget coloredContainer(double width) {
    return Container(
      height: 18,
      width: width,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color.fromRGBO(240, 45, 81, 1), Color.fromRGBO(242, 114, 26, 1)]
          )
      ),
    );
  }

  Widget icon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(width: 2, color: const Color.fromRGBO(240,81,45,1))),
      child: Icon(
        icon,
        color: Colors.black,
      ),
    );
  }
}
