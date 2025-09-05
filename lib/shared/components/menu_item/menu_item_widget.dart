import 'package:flutter/material.dart';

import '../../helpers/custom_colors.dart';

class MenuItemWidget extends StatelessWidget {
  final String? caption;
  final IconData? icon;
  final Function? onPressed;

  const MenuItemWidget({Key? key, this.caption, this.icon, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 10),
      child: InkWell(
        onTap: onPressed as void Function()?,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(
                icon,
                color: CustomColors.primary,
                size: 32,
              ),
            ),
            Text(
              caption!,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
