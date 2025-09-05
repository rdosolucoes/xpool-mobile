import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../shared/components/loading_progress_indicator/loading_progress_indicator_widget.dart';
import '../../../../../../shared/models/localization_model.dart';
import '../../../start_shop/domain/usecases/interfaces/get_needs_interface.dart';
import '../../../start_shop/presenter/stores/need_store.dart';
import '../../domain/usecases/interfaces/create_reference_interface.dart';
import '../../domain/usecases/interfaces/get_reference_suppliers_interface.dart';
import '../stores/referenceShop_store.dart';
import '../stores/supplierReferenceShop_store.dart';

class ReferenceShopController {
  SupplierReferenceShopStore supStore;
  ReferenceShopStore store;
  NeedStore needStore;

  void setLocalization(LocalizationModel? v) => store.setLocalization(v);
  void setName(String v) => store.setName(v);
  void setPhone(String v) => store.setPhone(v);
  void setDescription(String v) => store.setDescription(v);
  void setNeed(int v) => store.setNeed(v);
  void clearSupIds() => store.clearSupIds();

  void setCheck(int index, value) {
    var supplier = supStore.getSupplier(index);
    supStore.setCheck(index, value);
    if (value) {
      store.addSupId(supplier.id);
    } else {
      store.removeSupId(supplier.id);
    }
  }

  final IGetNeeds _getNeeds;
  final IGetReferenceSuppliers _getReferenceSuppliers;
  final ICreateReference _createReference;
  int filterActiveIndex = 0;

  ReferenceShopController(this.store, this._getReferenceSuppliers,
      this.needStore, this.supStore, this._createReference, this._getNeeds) {
    setFilterActiveIndex(1);

    if (needStore.state.needs.isEmpty) getNeeds();
  }

  Future<void> getReferenceSuppliers(int needId) async {
    supStore.setSuppliers(_getReferenceSuppliers(needId));
  }

  Future<void> getNeeds() async {
    needStore.setNeeds(_getNeeds());
  }

  String getLocalization() {
    if (store.state.localization != null) {
      return store.state.localization!.description;
    }

    return "";
  }

  Future<void> setFilterActiveIndex(int index) async {
    filterActiveIndex = index;
    var need = needStore.state.needs[index];
    clearSupIds();
    getReferenceSuppliers(need.id);
  }

  String getNeedDescription() {
    var need = needStore.state.needs[filterActiveIndex];
    setNeed(need.id);
    return need.description;
  }

  Future<void> createReference() async {
    var overlay = OverlayEntry(
      builder: (context) {
        return LoadingProgressIndicatorWidget(
          isCustom: true,
        );
      },
    );
    asuka.addOverlay(overlay);

    await Future.delayed(Duration(seconds: 3));

    var model = store.state;

    var result = await _createReference.call(model);
    overlay.remove();
    result.fold((l) {
      asuka.showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text("Falha ao realizar indicação"),
      ));
    }, (r) {
      asuka.showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Text("Indicação realizada com sucesso"),
      ));

      Modular.to.navigate('/startShop/homeShop');
    });
  }

  int getCountCheckedSup() {
    return store.state.supIds!.length;
  }

  bool hasBankAccount() {
    return supStore.state.suppliers[0].recipientId != '';
  }
}
