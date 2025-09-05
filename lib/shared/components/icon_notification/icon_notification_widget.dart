import 'package:flutter/material.dart';

import '../../helpers/custom_colors.dart';

class IconNotificationWidget extends StatelessWidget {
  final String title;
  final int counter;
  final bool active;

  const IconNotificationWidget(
      {Key? key,
      this.title = "IconNotificationWidget",
      this.counter = 0,
      this.active = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (counter == 0) {
      return Icon(
        Icons.notifications,
        size: 27,
        color: active ? CustomColors.primary : CustomColors.graniteGray,
      );
    }

    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.notifications,
            color: CustomColors.blueBar,
            size: 27,
          ),
          Container(
            width: 30,
            height: 30,
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(top: 5),
            child: Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffc32c37),
                  border: Border.all(color: Colors.white, width: 1)),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Center(
                  child: Text(
                    counter.toString(),
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
