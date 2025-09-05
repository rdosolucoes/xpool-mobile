import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/change_psw_entity.dart';
import 'change_psw_controller.dart';
import 'component/change_psw_form_widget.dart';

class ChangePswPage extends StatefulWidget {
  const ChangePswPage({Key? key}) : super(key: key);

  @override
  _ChangePswPageState createState() => _ChangePswPageState();
}

class _ChangePswPageState extends State<ChangePswPage> {
  var controller = Modular.get<ChangePswController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          controller.store.clear();
          Modular.to.popUntil(ModalRoute.withName("login"));
          return true;
        },
        child: Scaffold(
            appBar: AppBar(
              actions: [],
              centerTitle: true,
              title: Text("Alteração de Senha"),
            ),
            //backgroundColor: Colors.blue.shade50,

            body: Scaffold(
              body: TripleBuilder(
                store: controller.store,
                builder: (context, triple) {
                  return buildForm(
                      controller.store.error?.message, controller.store.state);
                },
              ),
            )));
  }

  Widget buildForm(String? messageError, ChangePswEntity model) {
    return ChangePswFormWidget(
      loading: false,
      errorMsg: messageError,
      confirmPasswordChanged: controller.setConfirmPassword,
      passwordChanged: controller.setPassword,
      confirmPressed: () => controller.changePassword(
          model.password, model.confirmPassword, messageError),
    );
  }
}
