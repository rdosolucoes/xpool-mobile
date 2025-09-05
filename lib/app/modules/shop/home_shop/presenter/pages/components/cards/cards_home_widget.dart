import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'card_item_widget.dart';

class CardsHomeWidget extends StatelessWidget {
  final String title;
  final int totalReferences;
  final int totalAccept;
  final int totalReject;
  final bool? isEmployee;

  const CardsHomeWidget(
      {Key? key,
      this.title = "CardsHomeWidget",
      this.totalReferences = 0,
      this.totalAccept = 0,
      this.totalReject = 0,
      this.isEmployee = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double? top = isEmployee == true ? 50 : 100;
    return Positioned(
      // height: 100,

      width: size.width,
      top: top,
      child: Container(
        margin: EdgeInsets.only(left: 15, top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CardItemWidget(
              label: "Indicações",
              value: totalReferences,
              icon: FontAwesomeIcons.peopleArrowsLeftRight,
              backgroundColor: Colors.blueGrey,
            ),
            CardItemWidget(
              label: "Aprovações",
              value: totalAccept,
              icon: FontAwesomeIcons.thumbsUp,
              backgroundColor: Colors.lightBlue,
            ),
            CardItemWidget(
              label: "Reprovações",
              value: totalReject,
              icon: FontAwesomeIcons.thumbsDown,
              backgroundColor: Colors.lightBlue,
            )
          ],
        ),
      ),
    );
  }
}
