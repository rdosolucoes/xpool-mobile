import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../../shared/components/circular_cached_image/circular_cached_image_widget.dart';
import '../../../../../../../shared/helpers/app_assets.dart';
import '../../../../../../../shared/helpers/consts.dart';
import '../../../../../../../shared/helpers/custom_colors.dart';
import '../../../infra/models/supplier_need_model.dart';

class SupplierTileShop extends StatelessWidget {
  final String name;
  final String city;
  final int status;
  final Function()? onPressedCreate;
  final Function()? onPressedDelete;
  final Function()? onPressedBreak;
  final String urlImage;
  final List<SupplierNeedModel>? needs;

  SupplierTileShop(
      {Key? key,
      required this.name,
      required this.city,
      required this.status,
      this.urlImage = "https://hajiri.co/uploads/no_image.jpg",
      this.onPressedCreate,
      this.onPressedDelete,
      this.onPressedBreak,
      this.needs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
        enabled: status == 1,
        key: ValueKey(0),
        endActionPane: ActionPane(
          motion: StretchMotion(),
          dismissible: null,
          children: [
            SlidableAction(
              onPressed: (context) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Confirmação'),
                        content: const Text(
                            'Você tem certeza que deseja desfazer esta parceria ?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                onPressedBreak!();
                                Navigator.of(context).pop();
                              },
                              child: const Text('Sim')),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Não'))
                        ],
                      );
                    });
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: FontAwesomeIcons.handshakeSlash,
              label: 'Desfazer Parceria',
            ),
          ],
        ),
        child: ListTile(
          dense: true,
          leading: CircularCachedNetworkImage(
            imageURL: urlImage.isEmpty ? imageDefaultSup : urlImage,
            size: 50,
            borderColor: Colors.white,
            borderWidth: 0,
          ),
          //dense: true,
          trailing: _buildTrailing(),

          title: Text(name),
          minVerticalPadding: 2,
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 2,
              ),
              Text(
                city,
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 4,
                runSpacing: 2,
                children: [
                  if (needs != null)
                    for (final need in needs!) ...[
                      CircleAvatar(
                          radius: 10,
                          backgroundImage:
                              AssetImage("${AppAssets.images}${need.image}"))
                    ]
                ],
              )
            ],
          ),
        ));
  }

  Widget _buildTrailing() {
    if (status == -1) {
      return Container(
        //margin: EdgeInsets.only(right: 15),
        child: TextButton(
          child: Text(
            "Convidar",
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0))),
            backgroundColor:
                MaterialStateProperty.all<Color>(CustomColors.primary),
          ),
          onPressed: onPressedCreate,
        ),
      );
    } else {
      if (status == -2) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(FontAwesomeIcons.spinner, color: Colors.lightBlue),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  "Pendente",
                  style:
                      TextStyle(fontSize: 12, color: CustomColors.graniteGray),
                ),
              )
            ]);
      } else {
        if (status == 1) {
          return Container(
            //color: Colors.black,
            padding: EdgeInsets.only(left: 12, right: 12),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.solidHandshake, color: Colors.green),
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      "Parceiros",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12, color: CustomColors.graniteGray),
                    ),
                  )
                ]),
          );
        } else {
          return Container(
            //margin: EdgeInsets.only(right: 15),
            child: TextButton(
              child: Text(
                "Desfazer",
                style: TextStyle(color: Colors.black),
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        side: BorderSide(),
                        borderRadius: BorderRadius.circular(8.0))),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.transparent),
              ),
              onPressed: onPressedDelete,
            ),
          );
        }
      }
    }
  }
}
