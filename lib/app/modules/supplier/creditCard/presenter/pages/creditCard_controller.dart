import 'package:asuka/asuka.dart' as asuka;
import 'package:credit_card_validator/credit_card_validator.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../shared/components/loading_progress_indicator/loading_progress_indicator_widget.dart';
import '../../../../../../shared/helpers/encryptData.dart';
import '../../domain/usecases/delete_creditCard.dart';
import '../../domain/usecases/get_all_creditCards.dart';
import '../../domain/usecases/post_creditCard.dart';
import '../../domain/usecases/set_default_creditCard.dart';
import '../stores/creditCard_store.dart';
import '../stores/creditCard_vm_store.dart';

class CreditCardController {
  final CreditCardVmStore vmStore;
  final CreditCardStore store;
  final GetAllCreditCards _getAllCreditCards;
  final PostCreditCard _postCreditCard;
  final DeleteCreditCard _deleteCreditCard;
  final SetDefaultCreditCard _setDefaultCreditCard;

  CreditCardController(
    this._getAllCreditCards,
    this._postCreditCard,
    this._deleteCreditCard,
    this._setDefaultCreditCard,
    this.vmStore,
    this.store,
  );

  void setHolderName(Encrypted? v) => store.setHolderName(v);
  void setNumber(Encrypted? v) => store.setNumber(v);
  void setValidateDate(Encrypted? v) => store.setValidateDate(v);
  void setCvv(Encrypted? v) => store.setCvv(v);
  void setBrand(String v) => store.setBrand(v);

  Future<void> getCreditCards() async {
    vmStore.setCreditCards(_getAllCreditCards());
  }

  bool validateCreditCard() {
    var _ccValidator = CreditCardValidator();
    var model = store.state;

    var numberDecrypt = EncryptData.decryptAES(model.number);
    var cvvDecrypt = EncryptData.decryptAES(model.cvv);
    var validateDateDecrypt = EncryptData.decryptAES(model.validateDate);

    var ccNumResults = _ccValidator.validateCCNum(numberDecrypt);
    var expDateResults = _ccValidator.validateExpDate(validateDateDecrypt);
    var cvvResults = _ccValidator.validateCVV(cvvDecrypt, ccNumResults.ccType);

    if (!ccNumResults.isPotentiallyValid) {
      asuka.showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('Número do cartão inválido'),
      ));
      return false;
    } else {
      setBrand(ccNumResults.ccType.name);
    }

    if (!expDateResults.isPotentiallyValid) {
      asuka.showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('Data de validade inválida'),
      ));
      return false;
    }

    if (!cvvResults.isPotentiallyValid) {
      asuka.showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('Cvv inválido'),
      ));
      return false;
    }

    return true;
  }

  Future<void> saveCreditCard(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (!validateCreditCard()) return;

    var model = store.state;

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

      var result = await _postCreditCard(model);

      result.fold((l) {
        asuka.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(l.message ?? ""),
        ));
      }, (r) {
        asuka.showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text("Cartão adicionado com Sucesso"),
        ));
        getCreditCards();
        Modular.to.pop();
      });
    } finally {
      overlay.remove();
    }
  }

  Future<void> delete(String cardId) async {
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

      var result = await _deleteCreditCard(cardId);

      result.fold((l) {
        asuka.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(l.message ?? ""),
        ));
      }, (r) {
        asuka.showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text("Cartão excluído com Sucesso"),
        ));
        getCreditCards();
      });
    } finally {
      overlay.remove();
    }
  }

  Future<void> setDefault(String cardId) async {
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

      var result = await _setDefaultCreditCard(cardId);

      result.fold((l) {
        asuka.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(l.message ?? ""),
        ));
      }, (r) {
        asuka.showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text("Novo cartão definido como Padrão"),
        ));
        getCreditCards();
      });
    } finally {
      overlay.remove();
    }
  }
}
