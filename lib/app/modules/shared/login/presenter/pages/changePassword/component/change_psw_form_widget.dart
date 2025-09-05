import 'package:flutter/material.dart';

import '../../../../../../../../../shared/components/default_flat_button/default_flat_button_widget.dart';
import '../../../../../../../../../shared/components/password_text_form_field/password_text_form_field_widget.dart';

class ChangePswFormWidget extends StatelessWidget {
  final bool loading;
  final VoidCallback confirmPressed;

  final Function(String) passwordChanged;
  final Function(String) confirmPasswordChanged;

  final String? errorMsg;

  ChangePswFormWidget({
    Key? key,
    required this.loading,
    required this.confirmPressed,
    required this.passwordChanged,
    required this.confirmPasswordChanged,
    this.errorMsg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return //Expanded(
        /* child:*/ SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
        child: Column(
          children: [
            SizedBox(height: 30),
            PasswordTextFormFieldWidget(
                fontColor: Colors.black.withOpacity(0.8),
                onChanged: passwordChanged,
                visiblePassword: false,
                label: 'Nova Senha',
                errorMessage: "errorMsg"),
            SizedBox(height: 20),
            PasswordTextFormFieldWidget(
                fontColor: Colors.black.withOpacity(0.8),
                onChanged: confirmPasswordChanged,
                visiblePassword: false,
                label: 'Confirma Nova Senha',
                errorMessage: "errorMsg"),
            SizedBox(height: 20),
            Visibility(
              visible: (errorMsg?.length ?? 0) != 0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: size.height * 0.3,
                  ),
                  child: Text(
                    errorMsg ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: DefaultFlatButtonWidget(
                      label: "CONFIRMAR", onPressed: confirmPressed),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
