import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../../shared/components/circular_cached_image/circular_cached_image_widget.dart';
import '../../../../../../../shared/helpers/custom_colors.dart';

class NotificationTileInviteShop extends StatelessWidget {
  final String name;
  final String message;
  final String city;
  final String urlImage;
  final String dateHour;
  final int status;
  final Function()? onPressedConfirm;
  final Function()? onPressedReject;

  NotificationTileInviteShop(
      {Key? key,
      this.name = "",
      this.message = "",
      this.city = "",
      this.urlImage = "https://hajiri.co/uploads/no_image.jpg",
      this.status = 0,
      this.onPressedConfirm,
      this.onPressedReject,
      this.dateHour = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        margin: EdgeInsets.all(0),
        color: Colors.grey[100],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        child: Row(children: [
          Expanded(
            child: ListTile(
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                      text: message.replaceAll('{0}', ''),
                      style: TextStyle(fontSize: 14, color: Colors.black)),
                ])),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(dateHour, style: TextStyle(fontSize: 14)),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (status == 1)
                                Container(
                                    padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                                    child: Row(
                                        textDirection: TextDirection.ltr,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text("Parceria Concretizada"),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Icon(
                                                FontAwesomeIcons.solidHandshake,
                                                color: Colors.green),
                                          )
                                        ]))
                              else if (status == 2)
                                Container(
                                    padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                                    child: Row(
                                        textDirection: TextDirection.ltr,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text("Parceria Negada"),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Icon(
                                                FontAwesomeIcons.handshakeSlash,
                                                color: Colors.red),
                                          )
                                        ]))
                              else ...[
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 5, right: 10),
                                    //width: size * 0.25,
                                    child: TextButton(
                                      child: Text(
                                        "Aceitar",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        8.0))),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                CustomColors.lightBlue),
                                      ),
                                      onPressed: onPressedConfirm,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 5),
                                    //width: size * 0.25,
                                    child: TextButton(
                                      child: Text(
                                        "Rejeitar",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        8.0))),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                CustomColors.field),
                                      ),
                                      onPressed: onPressedReject,
                                    ),
                                  ),
                                ),
                              ],
                            ])
                      ]),
                )),
          )
        ]));
  }
}
