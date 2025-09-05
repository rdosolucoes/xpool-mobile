import 'package:flutter/material.dart';

import '../../helpers/custom_colors.dart';

class HomeFlatButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;
  const HomeFlatButtonWidget({
    Key? key,
    required this.label,
    required this.onPressed,
    this.color = CustomColors.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            label,
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
          ),
        ),
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100))),
            backgroundColor: MaterialStateProperty.all<Color>(color)),
      ),
    );
  }
}
