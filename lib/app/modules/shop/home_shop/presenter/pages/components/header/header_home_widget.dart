import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../../../shared/components/circular_cached_image/circular_cached_image_widget.dart';
import '../../../../../../../../shared/helpers/consts.dart';
import '../../../../../../../../shared/helpers/custom_colors.dart';

class HeaderHomeWidget extends StatelessWidget {
  final String title;
  final String logo;
  final double saldo;
  final bool? isEmployee;

  const HeaderHomeWidget(
      {Key? key,
      this.title = "HeaderHomeWidget",
      this.logo = imageDefault,
      this.saldo = 0,
      this.isEmployee = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var f = NumberFormat.simpleCurrency(locale: 'pt_BR');
    var size = MediaQuery.of(context).size;
    return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [CustomColors.primary, CustomColors.primaryLight]),
          /* borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),*/
        ),
        padding: EdgeInsets.only(right: 10, left: 0, top: 40),
        width: double.infinity,
        height: 350,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: !isEmployee!,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 20),
                    child: Text('Saldo Total:',
                        style: TextStyle(color: Colors.white)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 0),
                    child: Text(f.format(saldo),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w500)),
                  )
                ],
              ),
            ),
            //SizedBox(width: 50),
            Expanded(
              child: Container(
                width: 10,
                margin: EdgeInsets.fromLTRB(40, 30, 10, 0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                          child: CircularCachedNetworkImage(
                        imageURL: logo,
                        size: size.width * 0.27,
                        borderColor: Colors.white,
                      )),
                      SizedBox(height: 5),
                      Container(
                        width: size.width * 0.27,
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                            height: 1.3,
                          ),
                          overflow: TextOverflow.clip,
                        ),
                      )
                    ]),
              ),
            )
          ],
        ));
  }
}
