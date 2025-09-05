import 'package:flutter/material.dart';

import '../../../../../../../shared/helpers/app_assets.dart';

class SupTileNeedsWidget extends StatelessWidget {
  final String description;
  final String icon;
  final Function(bool?) onChanged;
  final bool value;

  const SupTileNeedsWidget(
      {Key? key,
      required this.description,
      required this.icon,
      required this.onChanged,
      required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      elevation: 2,
      child: Container(
        //padding: EdgeInsets.all(5),

        child: CheckboxListTile(
          controlAffinity: ListTileControlAffinity.trailing,
          secondary: CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(AppAssets.images + icon),
          ),
          dense: true,
          title: Text(description,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5)),
          value: value,
          onChanged: onChanged,
          contentPadding: EdgeInsets.only(right: 10, left: 10),
        ),
      ),
    );
  }
}
