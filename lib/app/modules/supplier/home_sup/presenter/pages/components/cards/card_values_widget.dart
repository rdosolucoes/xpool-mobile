import 'package:flutter/material.dart';

class CardValuesWidget extends StatelessWidget {
  final int value;
  final String label;
  final bool active;
  const CardValuesWidget(
      {Key? key, this.value = 0, this.label = '', this.active = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value.toString(),
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 10),
          )
        ],
      ),
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        border: Border.all(
          color: active ? Colors.white : Colors.transparent,
          width: 1.0,
          style: BorderStyle.solid,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.blueAccent,
            blurRadius: 2.0,
            spreadRadius: 1,
          ),
        ],
        color: Colors.blue[800],
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
}
