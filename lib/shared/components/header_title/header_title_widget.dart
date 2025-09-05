import 'package:flutter/material.dart';
import '../../helpers/custom_colors.dart';

class HeaderTitleWidget extends StatelessWidget {
  final String title;
  const HeaderTitleWidget({Key? key, this.title = "HeaderTitleWidget"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.only(left: 20, bottom: 7),
      width: double.infinity,
      height: 40,
      color: CustomColors.primary,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
