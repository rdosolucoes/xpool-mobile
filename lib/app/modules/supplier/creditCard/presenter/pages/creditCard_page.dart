import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../shared/components/default_flat_button/default_flat_button_widget.dart';
import '../../../../../../shared/components/loading_shimmer/shimmer_widget.dart';
import '../../../../../../shared/helpers/app_assets.dart';
import '../../../../../../shared/helpers/custom_colors.dart';
import '../../../../../../shared/helpers/encryptData.dart';
import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/helpers/utils.dart';
import '../../../home_sup/presenter/pages/homeSup_controller.dart';
import '../stores/creditCard_vm_store.dart';
import '../view_models/creditCard_view_model.dart';
import 'components/creditCard_tile_widget.dart';
import 'creditCard_controller.dart';

class CreditCardPage extends StatefulWidget {
  final String title;
  const CreditCardPage({Key? key, this.title = 'Cartões de Crédito'})
      : super(key: key);
  @override
  CreditCardPageState createState() => CreditCardPageState();
}

class CreditCardPageState extends State<CreditCardPage> {
  var controller = Modular.get<CreditCardController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    controller.getCreditCards();
    super.initState();
  }

  Future<void> openFormEdit() async {
    showModalBottomSheet(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        isScrollControlled: true,
        builder: (context) {
          return SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                        30.0, 30.0, 30.0, 0.0), // content padding
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 10, right: 10),
                                      child: Icon(
                                        Icons.security,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "As informações do seu cartão de crédito estão protegidas",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "\nEstabelecemos parceria com uma plataforma de pagamento para garantir que os detalhes do seu cartão de crédito sejam bem protegidos. O XPool não terá acesso as informações do seu cartão de crédito.",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          )),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Dados do Cartão",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                          ),
                          TextFormField(
                            onChanged: ((value) => controller
                                .setNumber(EncryptData.encryptAES(value))),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              return value!.isNotEmpty
                                  ? null
                                  : "Informe o Número do Cartão";
                            },
                            decoration: InputDecoration(
                              labelText: 'Número do Cartão',
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CartaoBancarioInputFormatter(),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  onChanged: ((value) =>
                                      controller.setValidateDate(
                                          EncryptData.encryptAES(value))),
                                  validator: (value) {
                                    return value!.isNotEmpty
                                        ? null
                                        : "Informe a Data de Validade";
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: 'Validade (MM/AA)',
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    ValidadeCartaoInputFormatter(),
                                  ],
                                ),
                              ),
                              SizedBox(width: 40),
                              Container(
                                width: 80,
                                child: TextFormField(
                                  onChanged: ((value) => controller
                                      .setCvv(EncryptData.encryptAES(value))),
                                  validator: (value) {
                                    return value!.isNotEmpty
                                        ? null
                                        : "Informe o CVV";
                                  },
                                  keyboardType: TextInputType.number,
                                  maxLength: 3,
                                  decoration: InputDecoration(
                                    labelText: 'CVV',
                                    counterText: "",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TextFormField(
                            scrollPadding: EdgeInsets.only(top: 50),
                            onChanged: ((value) => controller
                                .setHolderName(EncryptData.encryptAES(value))),
                            validator: (value) {
                              return value!.isNotEmpty
                                  ? null
                                  : "Informe o Nome no Cartão";
                            },
                            decoration: InputDecoration(
                              labelText: 'Nome no Cartão',
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 30, bottom: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                DefaultFlatButtonWidget(
                                    label: "Confirmar",
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        controller.saveCreditCard(context);
                                      }
                                    }) //,
                                /*   TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Voltar")),*/
                              ],
                            ),
                          )
                        ],
                      ),
                    ), // From with TextField inside
                  )));
        },
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    var bottomFloat = 35.0;

    if (Platform.isIOS) {
      bottomFloat = bottomFloat * 2;
    }
    return WillPopScope(
        onWillPop: () async {
          try {
            var controller = Modular.get<HomeSupController>();
            controller.refreshValues();
          } on Exception catch (_) {
            return true;
          }

          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            //actions: [Image.asset(AppAssets.logo)],
            centerTitle: true,
            title: Text(widget.title),
          ),
          floatingActionButton: Container(
            margin: EdgeInsets.only(bottom: bottomFloat),
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: openFormEdit,
              child: const FaIcon(FontAwesomeIcons.plus, color: Colors.white),
              //color: Colors.white,
              //size: 20,
              // ),
              backgroundColor: CustomColors.primary,
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HeaderTitleWidget(title: "INFORME DADOS DA LOJA"),
              Expanded(
                child: ScopedBuilder<CreditCardVmStore, Failure, CreditCardVM>(
                  store: controller.vmStore,
                  onLoading: (_) => Center(child: ShimmerWidget()),
                  onError: (_, error) => Utils.buildError(
                      'Erro ao realizar busca: ${error?.message ?? ''}',
                      controller.getCreditCards()),
                  onState: (_, state) {
                    if (state.creditCards.length == 0) {
                      return Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppAssets.noCard,
                                scale: 1,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Nenhum cartão cadastrado',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              Text('Inclua seu primeiro cartão')
                            ]),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: controller.getCreditCards,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.grey.shade200,
                        ),
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 50),
                        itemCount: state.creditCards.length,
                        itemBuilder: (_, index) {
                          var creditCard = state.creditCards[index];

                          var brand = AppAssets.visa;

                          if (creditCard.brand.toUpperCase() == "MASTERCARD") {
                            brand = AppAssets.mastercard;
                          }

                          if (creditCard.brand.toUpperCase() == "ELO") {
                            brand = AppAssets.elo;
                          }

                          if (creditCard.brand.toUpperCase() == "AMEX") {
                            brand = AppAssets.amex;
                          }

                          if (creditCard.brand.toUpperCase() == "HIPERCARD") {
                            brand = AppAssets.hipercard;
                          }

                          if (creditCard.brand.toUpperCase() == "DINERS") {
                            brand = AppAssets.diners;
                          }

                          return CreditCardTileWidget(
                            creditCardId: creditCard.creditCardId,
                            name: creditCard.brand,
                            number: creditCard.lastFourDigits,
                            isDefault: creditCard.isDefault,
                            brand: brand,
                            pressDefault: controller.setDefault,
                            pressDelete: controller.delete,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }

  /*Widget buildForm(String? messageError, CreditCardEntity model) {
    return CreditCardFormWidget(
      model: model,
      holderNameChanged: controller.setHolderName,
      bankChanged: controller.setBank,
      branchNumberChanged: controller.setBranchNumber,
      branchCheckDigitChanged: controller.setBranchCheckDigit,
      accountNumberChanged: controller.setAccountNumber,
      accountCheckDigitChanged: controller.setAccountCheckDigit,
      holderTypeChanged: controller.setHolderType,
      holderDocumentChanged: controller.setHolderDocument,
      typeChanged: controller.setType,
      errorMsg: messageError,
      confirmPressed: () => controller.saveCreditCard(model),
    );
  }*/
}
