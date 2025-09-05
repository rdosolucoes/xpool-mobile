import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../shared/components/circular_cached_image/circular_cached_image_widget.dart';

class NotificationTileAdviceSup extends StatelessWidget {
  final String urlImage;
  final String name;
  final String message;
  final String dateHour;

  NotificationTileAdviceSup({
    Key? key,
    this.urlImage = "https://hajiri.co/uploads/no_image.jpg",
    required this.name,
    required this.message,
    required this.dateHour,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Modular.to.navigate('/startSup/homeSup');
      },
      child: Card(
          elevation: 0,
          margin: EdgeInsets.all(3),
          color: Colors.grey[100],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
          child: Row(children: [
            Expanded(
              child: ListTile(
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  leading: CircularCachedNetworkImage(
                    imageURL: urlImage,
                    size: 50,
                    borderColor: Colors.white,
                  ),
                  title: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: name,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    TextSpan(
                        text: message.replaceAll("{0}", ""),
                        style: TextStyle(fontSize: 14, color: Colors.black)),
                  ])),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(dateHour,
                              style: TextStyle(
                                  fontSize: 12, fontStyle: FontStyle.italic)),
                        ]),
                  )),
            )
          ])),
    );
  }
}
