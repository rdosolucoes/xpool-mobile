import 'package:flutter/material.dart';

class ReferenceIcons extends StatelessWidget {
  final String image;
  final String value;
  final int height;
  final int width;

  ReferenceIcons(
      {Key? key,
      this.image = '',
      this.value = '',
      this.height = 30,
      this.width = 30})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 10),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Image(image: AssetImage(image), height: 20, width: 20),
          SizedBox(width: 5),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(value,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
          ),
        ]));
  }
}
