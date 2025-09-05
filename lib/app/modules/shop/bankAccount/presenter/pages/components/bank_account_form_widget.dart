import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../../shared/components/default_dropdown_field/default_dropdown_field_widget.dart';
import '../../../../../../../shared/components/default_flat_button/default_flat_button_widget.dart';
import '../../../../../../../shared/components/default_text_form_field/default_text_form_field_widget.dart';
import '../../../../../../../shared/models/dropdown_model.dart';
import '../../../domain/entities/bank_account_entity.dart';

class BankAccountFormWidget extends StatelessWidget {
  final String title;
  final String address;
  final BankAccountEntity model;
  final Function(String) holderNameChanged;
  final Function(DropdownModel?) bankChanged;
  final Function(String) branchNumberChanged;
  final Function(String) branchCheckDigitChanged;
  final Function(String) accountNumberChanged;
  final Function(String) accountCheckDigitChanged;
  final Function(String) holderTypeChanged;
  final Function(String) holderDocumentChanged;
  final Function(String) typeChanged;
  final Future<List<DropdownModel>> Function(String?)? getBanks;

  final String errorCep;
  final String? errorMsg;
  final VoidCallback confirmPressed;

  const BankAccountFormWidget(
      {Key? key,
      this.title = "Conta Bancária",
      this.address = "",
      required this.model,
      required this.holderNameChanged,
      required this.bankChanged,
      required this.branchNumberChanged,
      required this.branchCheckDigitChanged,
      required this.accountNumberChanged,
      required this.accountCheckDigitChanged,
      required this.holderTypeChanged,
      required this.holderDocumentChanged,
      required this.typeChanged,
      required this.getBanks,
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
        child: Text("INFORME OS DADOS DE SUA CONTA",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        height: 30,
      ),
      Expanded(
        child: Container(
            margin: EdgeInsets.only(top: 15),
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    DefaultTextFormFieldWidget(
                        labelText: 'Nome Completo (Mesmo da Conta)',
                        fontColor: Colors.black.withOpacity(0.8),
                        onChanged: holderNameChanged,
                        text: model.holderName,
                        keyboardType: TextInputType.name,
                        errorMessage: errorMsg),
                    SizedBox(height: 15),
                    DefaultDropDownFieldWidget(
                      labelText: 'Nome do Banco',
                      fontColor: Colors.black.withOpacity(0.8),
                      getData: getBanks,
                      //items: banks,
                      selectedItem: DropdownModel(
                          id: model.bankCode != ''
                              ? int.parse(model.bankCode)
                              : 0,
                          name: model.bankName),
                      onChanged: bankChanged,
                      showSearchBox: true,
                      keyboardType: TextInputType.phone,
                      errorMessage: errorMsg,
                      inputFormatter: [
                        FilteringTextInputFormatter.digitsOnly,
                        TelefoneInputFormatter(),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: DefaultTextFormFieldWidget(
                            labelText: 'Agência',
                            fontColor: Colors.black.withOpacity(0.8),
                            onChanged: branchNumberChanged,
                            keyboardType: TextInputType.number,
                            text: model.branchNumber,
                            errorMessage: errorMsg,
                          ),
                        ),
                        SizedBox(width: 15),
                        Container(
                          width: 120,
                          child: DefaultTextFormFieldWidget(
                              labelText: 'Dígito',
                              fontColor: Colors.black.withOpacity(0.8),
                              onChanged: branchCheckDigitChanged,
                              keyboardType: TextInputType.number,
                              text: model.branchCheckDigit,
                              errorMessage: errorMsg),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: DefaultTextFormFieldWidget(
                            labelText: 'Conta',
                            fontColor: Colors.black.withOpacity(0.8),
                            onChanged: accountNumberChanged,
                            keyboardType: TextInputType.number,
                            errorMessage: errorMsg,
                            text: model.accountNumber,
                            maxLenght: 13,
                            counterText: "",
                          ),
                        ),
                        SizedBox(width: 15),
                        Container(
                          width: 70,
                          child: DefaultTextFormFieldWidget(
                              labelText: 'Dígito',
                              fontColor: Colors.black.withOpacity(0.8),
                              onChanged: accountCheckDigitChanged,
                              keyboardType: TextInputType.number,
                              text: model.accountCheckDigit,
                              errorMessage: errorMsg),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Conta Jurídica"),
                        Switch(
                            value:
                                model.holderType == "individual" ? false : true,
                            onChanged: (v) {
                              if (v) {
                                holderTypeChanged("company");
                              } else {
                                holderTypeChanged("individual");
                              }
                            }),
                        Text("Poupança"),
                        Switch(
                            value: model.type == "checking" ? false : true,
                            onChanged: (v) {
                              if (v) {
                                typeChanged("savings");
                              } else {
                                typeChanged("checking");
                              }
                            }),
                      ],
                    ),
                    SizedBox(height: 5),
                    DefaultTextFormFieldWidget(
                      labelText:
                          model.holderType == "individual" ? "Cpf" : "Cnpj",
                      fontColor: Colors.black.withOpacity(0.8),
                      onChanged: holderDocumentChanged,
                      keyboardType: TextInputType.number,
                      errorMessage: errorMsg,
                      text: model.holderDocument,
                      inputFormatter: [
                        FilteringTextInputFormatter.digitsOnly,
                        model.holderType == "individual"
                            ? CpfInputFormatter()
                            : CnpjInputFormatter(),
                      ],
                    ),
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
                    SizedBox(height: 20),
                  ]),
            )),
      ),
    ]);
  }
}
