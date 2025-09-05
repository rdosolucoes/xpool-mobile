import 'package:asuka/asuka.dart' as asuka;
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../../../shared/components/default_flat_button/default_flat_button_widget.dart';
import '../../../../../../../../../shared/components/default_text_field/default_text_field_widget.dart';
import '../../../../../../../../../shared/components/password_text_form_field/password_text_form_field_widget.dart';

class LoginFormWidget extends StatelessWidget {
  final bool loading;
  final VoidCallback loginPressed;

  final Function(String) userNameChanged;
  final Function(String) passwordChanged;
  final Function(String) confirmPasswordChanged;
  final Future<String> Function() rememberPassword;
  final Function() switchAuthMode;
  final String? errorMsg;
  final bool signMode;
  final String? password;
  LoginFormWidget({
    Key? key,
    required this.loading,
    required this.loginPressed,
    required this.userNameChanged,
    required this.passwordChanged,
    required this.confirmPasswordChanged,
    required this.rememberPassword,
    required this.switchAuthMode,
    this.errorMsg,
    this.signMode = false,
    this.password,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ListView(shrinkWrap: true, children: <Widget>[
      SizedBox(
        height: 10,
      ),
      DefaultTextFieldWidget(
          labelText: 'Cpf',
          fontColor: Colors.black.withOpacity(0.8),
          onChanged: userNameChanged,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Informe o CPF';
            }
            return "";
          },
          inputFormatter: [
            FilteringTextInputFormatter.digitsOnly,
            CpfInputFormatter(),
          ],
          errorMessage: errorMsg),
      SizedBox(height: 15),
      PasswordTextFormFieldWidget(
          fontColor: Colors.black.withOpacity(0.8),
          onChanged: passwordChanged,
          label: 'Senha',
          errorMessage: errorMsg),
      if (!signMode)
        Align(
          alignment: Alignment.topRight,
          child: TextButton(
            onPressed: () {
              rememberPassword().then((email) {
                if (email == "") {
                  asuka.showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Cpf incorreto ou não cadastrado."),
                  ));
                  //  }
                } else {
                  Modular.to.pushNamed("codeValidation", arguments: email);
                  //  }
                }
              });
            },
            child: Text("Esqueceu a Senha.",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue.shade900,
                    fontWeight: FontWeight.w600)),
          ),
        ),
      if (signMode)
        Column(children: [
          SizedBox(height: 15),
          PasswordTextFormFieldWidget(
              fontColor: Colors.black.withOpacity(0.8),
              visiblePassword: false,
              onChanged: confirmPasswordChanged,
              label: 'Confirma Senha',
              errorMessage: errorMsg),
        ]),
      Visibility(
        visible: (errorMsg?.length ?? 0) != 0,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: size.height * 0.3,
              ),
              child: Text(
                errorMsg ?? '',
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 15),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: DefaultFlatButtonWidget(
              label: "${!signMode ? 'ENTRAR' : 'CADASTRAR'}",
              onPressed: loginPressed,
            ),
          )
        ],
      ),
      SizedBox(height: 10),
      Container(
        //margin: EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: switchAuthMode,
              child: Text(
                  "${!signMode ? 'Não tem uma conta? Registre-se.' : 'Entre com sua conta.'}",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    ]);
  }
}
