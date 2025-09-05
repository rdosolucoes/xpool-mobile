// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../../shared/components/circular_cached_image/circular_cached_image_widget.dart';
import '../../../../../../../../shared/components/icon_button/icon_button_widget.dart';
import '../../../../../../../../shared/helpers/app_assets.dart';
import '../../../../../../../../shared/helpers/consts.dart';
import '../../../../../../../../shared/helpers/custom_colors.dart';
import 'reference_sup_icons_widget.dart';

class ReferenceSupTile extends StatelessWidget {
  final int integrationId;
  final String userOrig;
  final String urlLogo;
  final String dateHour;
  final String need;
  final String description;
  final String iconNeed;
  final String localMainText;
  final String localSecondaryText;
  final String latitude;
  final String longitude;
  final String totalReference;
  final String totalAccept;
  final String totalReject;
  final BuildContext context;
  final VoidCallback acceptReference;
  final VoidCallback rejectReference;
  final String cardDefault;
  final double refValue;

  ReferenceSupTile(
      {Key? key,
      required this.integrationId,
      this.userOrig = '',
      this.urlLogo = imageDefaultSup,
      this.dateHour = '',
      this.need = '',
      this.description = '',
      this.iconNeed = '',
      this.localMainText = '',
      this.localSecondaryText = '',
      this.latitude = '',
      this.longitude = '',
      this.totalReference = '0',
      this.totalAccept = '0',
      this.totalReject = '0',
      required this.acceptReference,
      required this.rejectReference,
      required this.context,
      required this.cardDefault,
      required this.refValue})
      : super(key: key);

  Future<void> onPressed() async {
    var size = MediaQuery.of(context).size;

    showMaterialModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 5,
      context: context,
      builder: (contextRef) => SingleChildScrollView(
        // reverse: true,
        child: Container(
            padding: EdgeInsets.fromLTRB(30, 20, 30, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          CircularCachedNetworkImage(
                              imageURL: urlLogo,
                              size: 80,
                              borderColor: Colors.transparent),
                          SizedBox(height: 3),
                          Text(
                            userOrig,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            softWrap: true,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: CustomColors.grey40),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                            child: Text(
                              need,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: CustomColors.darkBlue),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              dateHour,
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 20, top: 5),
                            width: size.width * 0.6,
                            child: Text(
                              "$localMainText" " - $localSecondaryText",
                              overflow: TextOverflow.visible,
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Descrição do Serviço:",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12,
                                      color: CustomColors.darkBlue),
                                ),
                                Text(
                                  description,
                                  textAlign: TextAlign.start,
                                  maxLines: 3,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                //SizedBox(height: 40),

                SizedBox(height: 5),
                Divider(),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Valor Indicação:",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                        "R\$ ${refValue.toStringAsFixed(2).replaceAll(".", ",")}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Forma Pagamento:",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(cardDefault,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                SizedBox(height: 20),
                Divider(),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Deseja aceitar essa indicação ?",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      )),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButtonWidget(
                          icon: Icons.thumb_up,
                          label: 'Aceitar',
                          onPressed: () {
                            if (cardDefault == '') {
                              showDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (contextMsg) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(32.0))),
                                      contentPadding: EdgeInsets.all(20),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(contextRef).pop();
                                              Navigator.of(contextMsg).pop();
                                              Modular.to
                                                  .pushNamed('/creditCard');
                                            },
                                            child: Text(
                                              'PROSSEGUIR',
                                              style: TextStyle(fontSize: 18),
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(contextMsg).pop();
                                            },
                                            child: Text('VOLTAR',
                                                style: TextStyle(fontSize: 18)))
                                      ],
                                      actionsAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      title: Center(child: Text("Aviso")),
                                      content: Text(
                                        'Para aceitar a indicação é necessário informar um cartão de crédito.\nFique tranquilo, trabalhamos com total sigilo e segurança. Seus dados não ficam armazenados em nossa plataforma.',
                                      )));
                            } else {
                              acceptReference();
                            }
                          },
                          color: Colors.green),
                      //SizedBox(width: 5),
                      IconButtonWidget(
                          icon: Icons.thumb_down,
                          label: 'Rejeitar',
                          onPressed: rejectReference,
                          color: CustomColors.flamingo),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Future<void> _openLocation() async {
    var urlMap =
        "https://www.google.com/maps/search/?api=1&query=$localMainText"
        " - $localSecondaryText";

    var uriMap = Uri.parse(urlMap);

    if (await canLaunchUrl(uriMap)) {
      await launchUrl(uriMap);
    } else {
      throw 'Could not launch Maps';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: ListTile(
            //visualDensity: VisualDensity.comfortable,
            leading: CircularCachedNetworkImage(
              imageURL: urlLogo,
              size: 56,
              borderColor: Colors.transparent,
              borderWidth: 0,
            ),
            //dense: true,
            title: Text(
              need,
              style: TextStyle(fontSize: 12),
            ),
            trailing: InkWell(
              onTap: _openLocation,
              child: Container(
                //padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                width: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.pin_drop,
                      color: CustomColors.flamingo,
                      size: 30,
                    ),
                    SizedBox(height: 3),
                    Flexible(
                      child: Text(
                        "$localMainText" " $localSecondaryText",
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            tileColor: CustomColors.darkBlue,
            minVerticalPadding: 3,
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 2,
                ),
                Text(
                  "$userOrig" " - " "$dateHour",
                  style: TextStyle(fontSize: 10),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    ReferenceSupIcons(
                        image: AppAssets.supplier, value: totalReference),
                    ReferenceSupIcons(
                        image: AppAssets.confirm, value: totalAccept),
                    ReferenceSupIcons(
                        image: AppAssets.reject, value: totalReject),
                  ],
                )
              ],
            )));
  }
}
