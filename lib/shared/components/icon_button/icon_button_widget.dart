import 'package:flutter/material.dart';

import '../../helpers/custom_colors.dart';

class IconButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;
  final IconData icon;
  const IconButtonWidget(
      {Key? key,
      required this.label,
      required this.onPressed,
      this.color = CustomColors.primary,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton.icon(
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        onPressed: onPressed,
        label: Text(
          label,
          style: TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
        ),
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100))),
            backgroundColor: MaterialStateProperty.all<Color>(color)),
      ),
    );
  }
}
