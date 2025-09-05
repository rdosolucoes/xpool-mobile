import 'package:flutter/material.dart';

class NumbersWidget extends StatelessWidget {
  final int totalReference;
  final int totalAprove;
  final int totalReprove;

  const NumbersWidget(
      {Key? key,
      this.totalReference = 0,
      this.totalAprove = 0,
      this.totalReprove = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(context, totalReference.toString(), 'Indicações'),
          buildDivider(),
          buildButton(context, totalAprove.toString(), 'Aprovações'),
          buildDivider(),
          buildButton(context, totalReprove.toString(), 'Reprovações'),
        ],
      );
  Widget buildDivider() => Container(
        height: 24,
        child: VerticalDivider(
          color: Colors.black,
        ),
      );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 2),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
