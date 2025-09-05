import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/sup_entity.dart';
import '../components/sup_form_widget.dart';
import 'registerSup_controller.dart';

class RegisterSupPage extends StatefulWidget {
  final String title;

  const RegisterSupPage({Key? key, this.title = ''}) : super(key: key);
  @override
  RegisterSupPageState createState() => RegisterSupPageState();
}

class RegisterSupPageState extends State<RegisterSupPage> {
  var controller = Modular.get<RegisterSupController>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //HeaderTitleWidget(title: "INFORME SEUS DADOS"),
          Expanded(
            child: Card(
              margin: EdgeInsets.all(2),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                padding: EdgeInsets.only(
                  left: size.width * 0.07,
                  right: size.width * 0.07,
                ),
                child: TripleBuilder(
                  store: controller.store,
                  builder: (context, triple) {
                    return buildForm(controller.store.error?.message,
                        controller.store.state);
                  },
                ),
              ),
            ),
          ),
        ]));
  }

  Widget buildForm(String? messageError, SupEntity model) {
    return SupFormWidget(
      nameChanged: controller.setName,
      emailChanged: controller.setEmail,
      phoneChanged: controller.setPhone,
      stateChanged: controller.setState,
      cityChanged: controller.setCity,
      cepChanged: controller.setCep,
      streetChanged: controller.setStreet,
      districtChanged: controller.setDistrict,
      numberChanged: controller.setNumber,
      complementChanged: controller.setComplement,
      searchCEP: controller.searchCEP,
      address: controller.getAddress(),
      errorCep: controller.getErrorCep(),
      errorMsg: messageError,
      confirmPressed: () => controller.confirm(model),
    );
  }
}
