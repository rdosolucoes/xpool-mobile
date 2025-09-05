import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../../../../../shared/auth/models/auth_model.dart';
import 'components/header/header_widget.dart';
import 'components/login_form/login_form_widget.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var controller = Modular.get<LoginController>();
  @override
  void initState() {
    controller.clearStore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: size.height,
        child: Stack(children: <Widget>[
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: HeaderWidget(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.38,
              left: size.width * 0.1,
              right: size.width * 0.1,
            ),
            child: TripleBuilder(
              store: controller.store,
              builder: (context, triple) {
                return buildForm(
                    controller.store.error?.message, controller.store.state);
              },
            ),
          ),
        ]),
      ),
    );
  }

  Widget buildForm(String? messageError, AuthModel model) {
    return LoginFormWidget(
      loading: false,
      userNameChanged: controller.setUserName,
      errorMsg: messageError,
      confirmPasswordChanged: controller.setConfirmPassword,
      rememberPassword: controller.rememberPassword,
      passwordChanged: controller.setPassword,
      signMode: model.isSignMode,
      password: model.password,
      switchAuthMode: controller.switchAuthMode,
      loginPressed: () => controller.login(
          model.userName, model.password, model.confirmPassword, messageError),
    );
  }

  @override
  void dispose() {
    //controller.store.destroy();
    super.dispose();
  }
}
