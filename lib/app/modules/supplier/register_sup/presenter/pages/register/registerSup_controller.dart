import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:search_cep/search_cep.dart';

import '../../../../../../../shared/components/loading_progress_indicator/loading_progress_indicator_widget.dart';
import '../../../domain/entities/sup_entity.dart';
import '../../../domain/usecases/validate_form.dart';
import '../../stores/registerSup_store.dart';

class RegisterSupController {
  final RegisterSupStore store;
  final ValidateForm _validateForm;

  RegisterSupController(this.store, this._validateForm);

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

  Future<void> confirm(SupEntity model) async {
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
        store.clearError();
        Modular.to.pushNamed('selectNeedsSup', arguments: model);
      }
    } finally {
      overlay.remove();
    }
  }
}
