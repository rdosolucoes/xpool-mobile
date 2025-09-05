import 'package:asuka/asuka.dart' as asuka;
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:search_cep/search_cep.dart';

import '../../../../../../shared/auth/local_storage/interfaces/auth_repository_interface.dart';
import '../../../../../../shared/auth/stores/auth_store.dart';
import '../../../../../../shared/components/loading_progress_indicator/loading_progress_indicator_widget.dart';
import '../../../../../../shared/helpers/enum.dart';
import '../../domain/entities/shop_entity.dart';
import '../../domain/usecases/interfaces/post_shop_interface.dart';
import '../../domain/usecases/interfaces/send_code_verify_interface.dart';
import '../../domain/usecases/validate_form.dart';
import '../stores/registerShop_store.dart';

class RegisterShopController {
  final RegisterShopStore store;
  final IPostShop _postShop;
  final AuthStore _authStore;
  final IAuthLocalStorage _localStorage;
  final ISendCodeVerify _sendCodeVerify;
  final ValidateForm _validateForm;

  RegisterShopController(this.store, this._postShop, this._authStore,
      this._localStorage, this._sendCodeVerify, this._validateForm);

  void setError(String v) => store.setErrorMsg(v);
  void setName(String v) => store.setName(v);
  void setEmail(String v) => store.setEmail(v);
  void setPhone(String v) => store.setPhone(v);
  void setCep(String v) => store.setCep(v);
  void setState(String v) => store.setState(v);
  void setCity(String v) => store.setCity(v);
  void setStreet(String v) => store.setStreet(v);
  void setDistrict(String v) => store.setDistrict(v);
  void setNumber(String v) => store.setNumber(v);
  void setComplement(String v) => store.setComplement(v);
  void setErrorCep(String v) => store.setErrorCep(v);

  String getAddress() {
    var storeState = store.state;
    var address = "";

    if (storeState.street != "") {
      address =
          "${storeState.street}, ${storeState.district} ${storeState.city} - ${storeState.state}";
    }

    return address;
  }

  String getErrorCep() {
    return store.state.errorCep;
  }

  Future<void> searchCEP(String v) async {
    final viaCepSearchCep = ViaCepSearchCep();
    final infoCepJSON = await viaCepSearchCep.searchInfoByCep(cep: v);
    String? street = "";
    String? state = "";
    String? city = "";
    String? district = "";

    infoCepJSON.fold((l) {
      setErrorCep(l.errorMessage);
    }, (r) {
      street = r.logradouro;
      city = r.localidade;
      state = r.uf;
      district = r.bairro;

      if (r.localidade == null) {
        setErrorCep("Cep não encontrado");
      } else {
        setErrorCep("");
      }
    });

    print(infoCepJSON);

    setStreet(street ?? "");
    setCity(city ?? "");
    setState(state ?? "");
    setDistrict(district ?? "");
  }

  Future<void> confirm(ShopEntity model) async {
    var isValidateForm = false;
    var messageError = "";

    var overlay = OverlayEntry(
      builder: (context) {
        return LoadingProgressIndicatorWidget(
          isCustom: true,
        );
      },
    );

    asuka.addOverlay(overlay);
    await Future.delayed(Duration(seconds: 1));

    try {
      var resultValidation =
          await _validateForm.call(model.name, model.email, model.phone);

      resultValidation.fold((l) {
        messageError = l.message!;
      }, (r) {
        isValidateForm = true;
      });

      if (model.validation.isNotEmpty) {
        asuka.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(model.validation),
        ));
      } else if (!isValidateForm) {
        asuka.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(messageError),
        ));
      } else {
        _sendCodeVerify(model.email, model.name, model.phone);
        Modular.to
            .pushNamed('/registerShop/codeValidationShop', arguments: model);
      }
    } finally {
      overlay.remove();
    }
  }

  Future<void> createUserShop(ShopEntity model) async {
    var overlay = OverlayEntry(
      builder: (context) {
        return LoadingProgressIndicatorWidget(
          isCustom: true,
        );
      },
    );
    asuka.addOverlay(overlay);
    await Future.delayed(Duration(seconds: 2));

    try {
      var result = await _postShop(model);

      store.setShop(result);

      print(store.state);
      // overlay.remove();

      if (result is Right) {
        _authStore.setTypeUser(ETypeUser.shop.index);
        _authStore.setName(model.name);
        _authStore.setEmailValidate(true);
        _localStorage.update(_authStore.state);
        Modular.to.navigate('/startShop/homeShop');
      }
    } finally {
      overlay.remove();
    }
  }
}
