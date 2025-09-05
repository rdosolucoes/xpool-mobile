import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../../shared/components/default_flat_button/default_flat_button_widget.dart';

class FormReferenceWidget extends StatelessWidget {
  final VoidCallback confirmPressed;
  final String need;
  final int countSup;
  final Function(String) nameChanged;
  final Function(String) phoneChanged;
  final Function(String) descriptionChanged;
  final _formKey = GlobalKey<FormState>();

  FormReferenceWidget(
      {Key? key,
      required this.confirmPressed,
      this.need = "",
      this.countSup = 1,
      required this.nameChanged,
      required this.phoneChanged,
      required this.descriptionChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var messageSup = "fornecedor selecionado.";

    if (countSup > 1) {
      messageSup = "fornecedores selecionados";
    }

    return SafeArea(
      child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 2, top: 20),
                child: Text(
                  "Dados da Indicação",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 28),
                ),
              ),
              Text(
                need,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  "$countSup $messageSup",
                  style: TextStyle(fontSize: 14),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          onChanged: nameChanged,
                          decoration: InputDecoration(
                            labelText: 'Nome Cliente',
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          onChanged: phoneChanged,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            TelefoneInputFormatter(),
                          ],
                          decoration: InputDecoration(
                            labelText: 'Contato',
                          ),
                        ),
                        TextFormField(
                          onChanged: descriptionChanged,
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          decoration: InputDecoration(
                            labelText: 'Descrição do Serviço',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Voltar")),
                    DefaultFlatButtonWidget(
                        label: "Confirmar",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            confirmPressed;
                          }
                        }),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
