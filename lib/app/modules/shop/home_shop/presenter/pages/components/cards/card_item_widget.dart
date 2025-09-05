import 'package:flutter/material.dart';

import '../../../../../../../../shared/helpers/custom_colors.dart';

class CardItemWidget extends StatelessWidget {
  final int value;
  final String label;
  final IconData icon;
  final Color backgroundColor;
  const CardItemWidget(
      {Key? key,
      this.value = 0,
      this.label = '',
      this.icon = Icons.outbound_sharp,
      this.backgroundColor = Colors.blue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,

          color: Colors.white60,
          // ),
          border: Border.all(
            color: Colors.white,
            width: 2.0,
            style: BorderStyle.solid,
          ),

          boxShadow: const [
            BoxShadow(
              color: Colors.white70,
              blurRadius: 2.0,
              spreadRadius: 1.5,
            ),
          ],
        ),
        margin: EdgeInsets.fromLTRB(0, 20, 10, 0),
        padding: EdgeInsets.all(10),
        width: 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value.toString(), //totalSuppliers!,
              style: TextStyle(
                  color: CustomColors.primary,
                  fontSize: 16,
                  //color: CustomColors.blueBar,
                  fontWeight: FontWeight.w600),
            ),
            Icon(
              icon,
              color: CustomColors.primary,
              size: 14,
            )
          ],
        ));
  }
}
