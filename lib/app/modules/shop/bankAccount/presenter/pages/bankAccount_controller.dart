import 'package:asuka/asuka.dart' as asuka;
import 'package:brazilian_banks/brazilian_banks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../shared/components/loading_progress_indicator/loading_progress_indicator_widget.dart';
import '../../../../../../shared/models/dropdown_model.dart';
import '../../../reference_shop/presenter/pages/referenceShop_controller.dart';
import '../../domain/entities/bank_account_entity.dart';
import '../../domain/usecases/get_bank_account.dart';
import '../../domain/usecases/post_bank_account.dart';
import '../stores/bankAccount_store.dart';

class BankAccountController {
  final BankAccountStore store;
  final GetBankAccount _getBankAccount;
  final PostBankAccount _postBankAccount;

  BankAccountController(
      this._getBankAccount, this._postBankAccount, this.store);

  void setHolderName(String v) => store.setHolderName(v);
  void setBank(DropdownModel? v) {
    store.setBankCode(v!.id.toString().padLeft(3, "0"));
    store.setBankName(v.name);
  }

  void setBranchNumber(String v) => store.setBranchNumber(v);
  void setBranchCheckDigit(String v) => store.setBranchCheckDigit(v);
  void setAccountNumber(String v) => store.setAccountNumber(v);
  void setAccountCheckDigit(String v) => store.setAccountCheckDigit(v);
  void setHolderType(String v) => store.setHolderType(v);
  void setHolderDocument(String v) => store.setHolderDocument(v);
  void setType(String v) => store.setType(v);

  bool callBank = false;
  int index = 1;

  void clearFields() {
    store.clear();
  }

  Future<void> getBankAccount() async {
    callBank = true;
    store.setBankAccount(await _getBankAccount());
    callBank = false;
  }

  Future<List<DropdownModel>> getBanks(String? s) async {
    var banksApi = await BrasilApiBanks.getBanks();

    var banks = banksApi
        .map((e) => DropdownModel(
            id: e.code ?? 0,
            name: e.code != null
                ? "${e.code.toString().padLeft(3, '0')} - ${e.name!}"
                : e.name!))
        .where((e) => e.id > 0)
        .toList();

    return banks;
  }

  Future<void> saveBankAccount(BankAccountEntity model) async {
    var overlay = OverlayEntry(
      builder: (context) {
        return LoadingProgressIndicatorWidget(
          isCustom: true,
        );
      },
    );

    try {
      asuka.addOverlay(overlay);
      await Future.delayed(Duration(seconds: 2));

      var result = await _postBankAccount(model);

      result.fold((l) {
        asuka.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(l.message ?? ""),
        ));
      }, (r) {
        Modular.to.pop();

        if (index != -1) {
          var controller = Modular.get<ReferenceShopController>();
          controller.setFilterActiveIndex(index);
        }

        asuka.showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text("Conta Bancária Atualizada com Sucesso"),
        ));
      });
    } finally {
      overlay.remove();
    }
  }

  bool hasValue() {
    return store.state.holderName != "";
  }
}
