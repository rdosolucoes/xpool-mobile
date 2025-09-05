import 'package:flutter/material.dart';

class ReferenceSupIcons extends StatelessWidget {
  final String image;
  final String value;
  final int height;
  final int width;

  ReferenceSupIcons(
      {Key? key,
      this.image = '',
      this.value = '',
      this.height = 25,
      this.width = 25})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Image(image: AssetImage(image), height: 25, width: 25),
      SizedBox(width: 5),
      Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Text(value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
      ),
    ]);
  }
}
