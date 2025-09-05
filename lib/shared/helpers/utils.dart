import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import 'app_assets.dart';
import 'custom_colors.dart';

class Utils {
  static Widget buildError(String error, void onPressed) {
    var errorDefault = "Serviço Indisponível no Momento.";
    return Container(
        margin: EdgeInsets.only(bottom: 35),
        padding: EdgeInsets.only(
          left: 40,
          right: 40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/sad.png",
              width: 60,
              height: 60,
            ),
            SizedBox(height: 10),
            Text(
              "Oh não !!",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              errorDefault,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: CustomColors.primary,
                  fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              "Verifique sua conexão e tente novamente mais tarde.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
            TextButton(
                onPressed: () => onPressed,
                child: Icon(
                  Icons.update,
                  size: 25,
                ))
          ],
        ));
  }

  static Widget buildNoItensFound(
      String titleMsg, String subTitleMsg, void onRefresh) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.partnershiplogo,
              scale: 4,
            ),
            Text(
              titleMsg,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(subTitleMsg),
            TextButton(
                onPressed: () => onRefresh,
                child: Icon(
                  Icons.update,
                  size: 30,
                ))
          ]),
    );
  }

  static bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    var regex = RegExp(pattern as String);
    var result = (!regex.hasMatch(value)) ? false : true;
    return result;
  }

  static bool validatePhone(String value) {
    // Null or empty string is invalid phone number
    if (value == "" || value.isEmpty) {
      return false;
    }

    // You may need to change this pattern to fit your requirement.
    // I just copied the pattern from here: https://regexr.com/3c53v
    const pattern = r'^\([1-9]{2}\) (?:[2-8]|9[1-9])[0-9]{3}\-[0-9]{4}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }

  static bool hasConnection() {
    var hasWifi = false;
    var hasMobileConnection = false;
    var connectivityResult = (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      hasMobileConnection = true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      hasWifi = true;
    }
    return hasWifi || hasMobileConnection;
  }
}
