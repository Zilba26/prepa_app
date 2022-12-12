import 'package:flutter/material.dart';

class RadioButton extends StatefulWidget {

  final dynamic value;
  final dynamic groupValue;

  const RadioButton({Key? key, this.value, this.groupValue}) : super(key: key);

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          (widget.groupValue == widget.value) ? Icons.radio_button_checked : Icons.radio_button_unchecked,
          color: Colors.blue,
        ),
        const SizedBox(width: 8),
        Text(widget.value)
      ],
    );
  }
}
