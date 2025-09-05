import 'package:flutter/material.dart';

import '../../helpers/custom_colors.dart';

class DefaultFlatButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const DefaultFlatButtonWidget({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100))),
            backgroundColor:
                MaterialStateProperty.all<Color>(CustomColors.primary)),
      ),
    );
  }
}
