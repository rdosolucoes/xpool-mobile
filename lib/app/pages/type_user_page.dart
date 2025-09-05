import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/components/default_flat_button/default_flat_button_widget.dart';
import '../../shared/helpers/app_assets.dart';

class TypeUserPage extends StatefulWidget {
  final String title;

  const TypeUserPage({Key? key, this.title = 'Qual seu Perfil ?'})
      : super(key: key);
  @override
  TypeUserPageState createState() => TypeUserPageState();
}

class TypeUserPageState extends State<TypeUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(top: 30, bottom: 50),
                  child: Text(
                    "Qual seu Perfil ?",
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  )),
              Column(
                children: [
                  Image.asset(
                    AppAssets.noImage,
                    scale: 3,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: DefaultFlatButtonWidget(
                              label: "LOJISTA",
                              onPressed: () {
                                Modular.to.pushNamed('/registerShop');
                              }),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 50),
              Column(
                children: [
                  Image.asset(
                    AppAssets.piscineiro,
                    scale: 3,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: DefaultFlatButtonWidget(
                              label: "FORNECEDOR",
                              onPressed: () {
                                Modular.to.pushNamed('/registerSup');
                              }),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              /*  TextButton(
                  onPressed: () {
                    Modular.to.navigate('/login');
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Sair",
                      style: TextStyle(fontSize: 16),
                    ),
                  ))*/
            ],
          ),
        ),
      ),
    );
  }
}
