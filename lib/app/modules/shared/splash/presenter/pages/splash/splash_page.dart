import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'splash_controller.dart';

class SplashPage extends StatefulWidget {
  final String title;
  const SplashPage({Key? key, this.title = 'SplashPage'}) : super(key: key);
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  var controller = Modular.get<SplashController>();
  @override
  void initState() {
    super.initState();
    controller.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromRGBO(236, 235, 242, 1),
              Color.fromRGBO(177, 226, 241, 1),
              /*  Color(0xFF8325BB),
              Color(0xFFAF1A7D),
              Color(0xFFCB2E6C),
              Color(0xFFDE94BC),*/
            ],
          ),
        ),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 0),
                  /*  child: IoasysLogoWidget(
                    size: screenHeight * 0.11,
                  ),*/
                  child: Image.asset(
                    "assets/images/logo_home.png",
                    width: MediaQuery.of(context).size.height * .40,
                    height: MediaQuery.of(context).size.height * .40,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
