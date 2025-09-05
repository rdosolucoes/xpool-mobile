import 'package:flutter/material.dart';

import '../../../../../../../../../shared/components/header_clipper/header_clipper.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: 0.0,
      duration: Duration(seconds: 10),
      upperBound: 1,
      lowerBound: -1,
      vsync: this,
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ClipPath(
            clipper: HeaderClipper(_controller.value),
            child: Stack(
              children: [
                Container(
                  height: size.height * 0.45,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromRGBO(236, 235, 242, 1),
                          Color.fromRGBO(177, 226, 241, 1),
                        ]),
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                          //mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //SizedBox(height: 2),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Seja bem vindo ao",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,

                                          //fontFamily: "Rubik",
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .065,
                                          color: Colors.blue[900])),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text("Sua Plataforma de Piscinas !",
                                        style: TextStyle(
                                            fontFamily: "Rubik",
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .042,
                                            color: Colors.blue[900])),
                                  )
                                ]),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Image.asset(
                                  "assets/images/logo_home.png",
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
