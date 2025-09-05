import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../../../shared/components/circular_cached_image/circular_cached_image_widget.dart';
import '../../../../../../../shared/helpers/app_assets.dart';
import '../../../../../../../shared/helpers/consts.dart';
import '../../../../../../../shared/helpers/custom_colors.dart';

// ignore: must_be_immutable
class MyReferenceTileSup extends StatelessWidget {
  final int referenceId;
  final String shopLogo;
  final String shopName;
  final String customerName;
  final String customerPhone;
  final String taskDescription;
  final String dateReference;
  final String needDescription;
  final String needIcon;
  final String localMainText;
  final String localSecondaryText;
  final String latitude;
  final String longitude;
  bool canContest;
  final int status;
  final String reply;
  final int doneDeal;
  final Function(int referenceId, String message) pressSendDispute;
  final Function(int value, int referenceId) pressSetDoneDeal;

  MyReferenceTileSup(
      {Key? key,
      this.referenceId = 0,
      this.shopLogo = "",
      required this.shopName,
      required this.customerName,
      required this.customerPhone,
      this.taskDescription = "",
      this.dateReference = "",
      this.needDescription = "",
      this.needIcon = "https://hajiri.co/uploads/no_image.jpg",
      this.localMainText = "",
      this.localSecondaryText = "",
      this.latitude = "",
      this.longitude = "",
      this.canContest = false,
      this.status = 1,
      this.reply = "",
      this.doneDeal = -1,
      required this.pressSendDispute,
      required this.pressSetDoneDeal})
      : super(key: key);

  Future<void> _makePhoneCall() async {
    var formatPhone = customerPhone.replaceAll(RegExp('[^0-9,.]'), "");

    var url = "tel:$formatPhone";

    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _abrirWhatsApp() async {
    var formatPhone = customerPhone.replaceAll(RegExp('[^0-9,.]'), "");

    var msgDefault =
        "Olá,tudo bem ? Sou prestador de serviços de piscinas e fui indicado pela loja $shopName. Em que posso ajuda-lo(a) ?";

    var url = "whatsapp://send?phone=+55$formatPhone&text= $msgDefault";

    if (Platform.isIOS) {
      url = "https://wa.me/+55$formatPhone/?text=${Uri.encodeFull(msgDefault)}";
    }

    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
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
    var opacity = 1.0;
    var ignorePoint = false;
    var hasInfo = false;

    if (reply != "") {
      hasInfo = true;
      canContest = true;
    }

    if (status == 3) {
      opacity = 0.4;
      ignorePoint = true;
      canContest = false;
    }

    void _showDialog(String title, String content) {
      showDialog(
        context: context,
        builder: (context) {
          // retorna um objeto do tipo Dialog
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              // define os botões na base do dialogo
              TextButton(
                child: Text("Fechar",
                    style: TextStyle(color: CustomColors.primary)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    void _showDoneDealDialog() {
      showDialog(
        //show confirm dialogue
        //the return value will be from "Yes" or "No" options
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Fechou a Indicação ?'),
          content: Text(
              'Esperamos que você tenha feito um ótimo negócio!\nRegistre aqui se você conseguiu fechar com o cliente final.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                pressSetDoneDeal(1, referenceId);
                Navigator.of(context).pop(false);
              },
              //return false when click on "NO"
              child: Text('Sim', style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: () {
                pressSetDoneDeal(2, referenceId);
                Navigator.of(context).pop(false);
              },

              //return true when click on "Yes"
              child: Text('Não', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    }

    void _showReversalDialog() {
      var fieldController = TextEditingController();
      final _formKey = GlobalKey<FormState>();

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              contentPadding: EdgeInsets.only(top: 10.0),
              content: SingleChildScrollView(
                child: Container(
                  width: 300.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "Contestar Indicação",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Divider(
                        color: Colors.grey,
                        height: 4.0,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 30.0, right: 30.0),
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              controller: fieldController,
                              decoration: InputDecoration(
                                hintText: "Informe o Motivo",
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                return value!.isNotEmpty
                                    ? null
                                    : "*Obrigatório Informar o Motivo";
                              },
                              maxLines: 8,
                            ),
                          )),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            pressSendDispute(referenceId, fieldController.text);
                            Navigator.of(context).pop();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                          decoration: BoxDecoration(
                            color: CustomColors.primary,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(32.0),
                                bottomRight: Radius.circular(32.0)),
                          ),
                          child: Text(
                            "Confirmar",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    }

    return InkWell(
        onTap: () {
          if (!ignorePoint) {
            _showDialog("Mais Informações", taskDescription);
          }
        },
        child: Opacity(
            opacity: opacity,
            child: IgnorePointer(
              ignoring: ignorePoint,
              child: Slidable(
                enabled: canContest,
                endActionPane: ActionPane(
                  motion: StretchMotion(),
                  children: [
                    SlidableAction(
                        onPressed: (context) {
                          hasInfo
                              ? _showDialog("Resposta da Loja", reply)
                              : _showReversalDialog();
                        },
                        backgroundColor:
                            hasInfo ? Colors.blue : Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: hasInfo ? Icons.info : Icons.campaign_outlined,
                        label: hasInfo ? 'Resposta' : 'Contestar'),
                  ],
                ),
                child: ListTile(
                    leading: CircularCachedNetworkImage(
                        imageURL: shopLogo.isEmpty ? imageDefault : shopLogo,
                        size: 55,
                        borderColor: Colors.transparent,
                        borderWidth: 0),
                    contentPadding: EdgeInsets.all(10),
                    title: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          needDescription,
                          style: TextStyle(
                              overflow: TextOverflow.clip,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        Visibility(
                          visible: hasInfo,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Icon(
                              Icons.info,
                              size: 15,
                              color: Colors.blue,
                            ),
                          ),
                        )
                      ],
                    ),
                    trailing: InkWell(
                      onTap: _openLocation,
                      child: Container(
                        padding: EdgeInsets.all(0),
                        margin: EdgeInsets.all(0),
                        width: 60,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.pin_drop,
                              color: CustomColors.flamingo,
                              size: 28,
                            ),
                            SizedBox(height: 3),
                            Flexible(
                              child: Text(
                                "$localMainText" " $localSecondaryText",
                                maxLines: 3,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.center,
                                style:
                                    TextStyle(fontSize: 8, color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //tileColor: CustomColors.darkBlue,
                    tileColor: Colors.grey[100],
                    minVerticalPadding: 5,
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 2),
                        Text(
                          customerName,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          customerPhone,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          "$shopName" " - " "$dateReference",
                          style: TextStyle(fontSize: 10),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Visibility(
                              visible: !ignorePoint,
                              child: Container(
                                  height: 35,
                                  width: 35,
                                  margin: EdgeInsets.only(right: 5),
                                  child: IconButton(
                                      padding: EdgeInsets.all(0),
                                      onPressed: _makePhoneCall,
                                      icon: Image.asset(
                                        AppAssets.phone,
                                      ))),
                            ),
                            Visibility(
                              visible: !ignorePoint,
                              child: Container(
                                  height: 35,
                                  width: 35,
                                  //padding: EdgeInsets.all(10),
                                  child: IconButton(
                                      padding: EdgeInsets.all(0),
                                      onPressed: _abrirWhatsApp,
                                      icon: Image.asset(
                                        AppAssets.whatsapp,
                                      ))),
                            ),
                            SizedBox(width: 22),
                            if (doneDeal == 0)
                              Visibility(
                                  visible: !ignorePoint,
                                  child: Expanded(
                                    child: TextButton(
                                      child: Text(
                                        'Fechou ?',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: _showDoneDealDialog,
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100))),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  CustomColors.primary)),
                                    ),
                                  ))
                            else if (doneDeal == 1)
                              Visibility(
                                  visible: !ignorePoint,
                                  child: Expanded(
                                    child: TextButton(
                                      child: Text(
                                        'Fechou',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {},
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100))),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.green)),
                                    ),
                                  ))
                            else if (doneDeal == 2)
                              Visibility(
                                  visible: !ignorePoint,
                                  child: Expanded(
                                    child: TextButton(
                                      child: Text(
                                        'Recusou',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {},
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100))),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.red)),
                                    ),
                                  )),
                            Visibility(
                                visible: ignorePoint,
                                child: Text(
                                  "Contestado",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                )),
                          ],
                        )
                      ],
                    )),
              ),
            )));
  }
}
