import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../../shared/components/default_flat_button/default_flat_button_widget.dart';
import '../../../../../../../shared/components/default_text_field/default_text_field_widget.dart';

class ShopFormWidget extends StatelessWidget {
  final String title;
  final String address;
  final Function(String) nameChanged;
  final Function(String) phoneChanged;
  final Function(String) emailChanged;
  final Function(String) cepChanged;
  final Future<void> Function(String) searchCEP;
  final Function(String) stateChanged;
  final Function(String) cityChanged;
  final Function(String) streetChanged;
  final Function(String) districtChanged;
  final Function(String) numberChanged;
  final Function(String) complementChanged;
  final String errorCep;
  final String? errorMsg;
  final VoidCallback confirmPressed;

  const ShopFormWidget(
      {Key? key,
      this.title = "ShopFormWidget",
      this.address = "",
      required this.nameChanged,
      required this.phoneChanged,
      required this.emailChanged,
      required this.cepChanged,
      required this.stateChanged,
      required this.cityChanged,
      required this.streetChanged,
      required this.districtChanged,
      required this.numberChanged,
      required this.complementChanged,
      required this.searchCEP,
      this.errorCep = "",
      this.errorMsg,
      required this.confirmPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        alignment: Alignment.bottomLeft,
        margin: EdgeInsets.only(top: 10),
        child: Text("INFORME OS DADOS DA LOJA",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        height: 30,
      ),
      Expanded(
        child: Container(
            margin: EdgeInsets.only(top: 15),
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    DefaultTextFieldWidget(
                        textCapitalization: TextCapitalization.words,
                        labelText: 'Nome',
                        fontColor: Colors.black.withOpacity(0.8),
                        onChanged: nameChanged,
                        keyboardType: TextInputType.name,
                        maxLenght: 25,
                        errorMessage: errorMsg),
                    //SizedBox(height: 20),
                    DefaultTextFieldWidget(
                      labelText: 'Celular',
                      fontColor: Colors.black.withOpacity(0.8),
                      onChanged: phoneChanged,
                      keyboardType: TextInputType.phone,
                      errorMessage: errorMsg,
                      inputFormatter: [
                        FilteringTextInputFormatter.digitsOnly,
                        TelefoneInputFormatter(),
                      ],
                    ),

                    SizedBox(height: 20),
                    DefaultTextFieldWidget(
                      labelText: 'Email',
                      fontColor: Colors.black.withOpacity(0.8),
                      onChanged: emailChanged,
                      keyboardType: TextInputType.emailAddress,
                      errorMessage: errorMsg,
                    ),
                    SizedBox(height: 20),
                    DefaultTextFieldWidget(
                        labelText: 'Cep',
                        fontColor: Colors.black.withOpacity(0.8),
                        onChanged: (v) {
                          cepChanged(v);
                          if (v.length >= 8) {
                            searchCEP(v);
                          }
                        },
                        keyboardType: TextInputType.number,
                        errorMessage: errorMsg),
                    SizedBox(height: 5),
                    Visibility(
                      visible: address != "" || errorCep != "",
                      child: Text(
                        errorCep == '' ? address : errorCep,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: errorCep == '' ? Colors.grey : Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                    ),

                    SizedBox(height: 10),
                    DefaultTextFieldWidget(
                        labelText: 'Número',
                        fontColor: Colors.black.withOpacity(0.8),
                        onChanged: numberChanged,
                        keyboardType: TextInputType.name,
                        errorMessage: errorMsg),
                    SizedBox(height: 20),
                    DefaultTextFieldWidget(
                        labelText: 'Complemento',
                        fontColor: Colors.black.withOpacity(0.8),
                        onChanged: complementChanged,
                        keyboardType: TextInputType.name,
                        errorMessage: errorMsg),
                    SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: DefaultFlatButtonWidget(
                              label: "CONFIRMAR",
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                confirmPressed();
                              } //loginPressed,
                              ),
                        )
                      ],
                    ),
                    SizedBox(height: 50),
                  ]),
            )),
      ),
    ]);
  }
}
