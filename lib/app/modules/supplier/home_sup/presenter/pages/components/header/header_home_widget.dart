import 'package:flutter/material.dart';

import '../../../../../../../../shared/components/circular_cached_image/circular_cached_image_widget.dart';
import '../../../../../../../../shared/helpers/custom_colors.dart';

class HeaderHomeWidget extends StatelessWidget {
  final String title;
  final String? logo;
  const HeaderHomeWidget({Key? key, this.title = "", this.logo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [CustomColors.primary, CustomColors.primaryLight]),
      ),
      padding: EdgeInsets.only(right: 10, left: 10, top: 50),
      width: double.infinity,
      height: 280,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              child: CircularCachedNetworkImage(
            imageURL: logo!,
            size: size.width * 0.28,
            borderColor: Colors.white,
          )),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(fontSize: 20, color: Colors.white),
          )
        ],
      ),
    );
  }
}
