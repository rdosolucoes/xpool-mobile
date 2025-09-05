import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../domain/entities/bank_account_entity.dart';
import 'bankAccount_controller.dart';
import 'components/bank_account_form_widget.dart';

class BankAccountPage extends StatefulWidget {
  final String title;
  const BankAccountPage({Key? key, this.title = 'Conta Bancária'})
      : super(key: key);
  @override
  BankAccountPageState createState() => BankAccountPageState();
}

class BankAccountPageState extends State<BankAccountPage> {
  var controller = Modular.get<BankAccountController>();

  @override
  void initState() {
    controller.getBankAccount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    if (ModalRoute.of(context)!.settings.arguments != null) {
      var args = ModalRoute.of(context)!.settings.arguments as Map<String, int>;
      controller.index = args["index"] as int;
    } else {
      controller.index = -1;
    }

    return Scaffold(
      appBar: AppBar(
        //actions: [Image.asset(AppAssets.logo)],
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HeaderTitleWidget(title: "INFORME DADOS DA LOJA"),
          Expanded(
            child: Card(
              margin: EdgeInsets.all(2),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                height: size.height * 0.9,
                padding: EdgeInsets.only(
                  left: size.width * 0.07,
                  right: size.width * 0.07,
                ),
                child: TripleBuilder(
                  store: controller.store,
                  builder: (context, triple) {
                    if (triple.isLoading || controller.callBank) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return buildForm(controller.store.error?.message,
                          controller.store.state);
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildForm(String? messageError, BankAccountEntity model) {
    return BankAccountFormWidget(
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
      getBanks: controller.getBanks,
      confirmPressed: () => controller.saveBankAccount(model),
    );
  }
}
