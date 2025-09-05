import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';

import '../../../../../../shared/auth/stores/auth_store.dart';
import '../../domain/usecases/interfaces/delete_reference_interface.dart';
import '../../domain/usecases/interfaces/get_references_shop_interface.dart';
import '../../domain/usecases/interfaces/get_suppliers_by_reference_interface.dart';
import '../../domain/usecases/interfaces/get_values_header_interface.dart';
import '../stores/headerShop_store.dart';
import '../stores/homeShop_store.dart';

class HomeShopController {
  final HomeShopStore store;
  final HeaderShopStore storeHeader;
  final AuthStore authStore;
  final IGetValuesHeader _getValuesHeader;
  final IGetReferencesShop _getReferencesShop;
  final IGetSuppliersByReference _getSuppliersByReference;
  final IDeleteReference _deleteReference;

  HomeShopController(
      this.store,
      this.authStore,
      this.storeHeader,
      this._getValuesHeader,
      this._getReferencesShop,
      this._getSuppliersByReference,
      this._deleteReference);

  Future<void> getValuesHeader() async {
    var result = await _getValuesHeader.call();

    result.fold((l) => null, (r) {
      var totalAccept = r.totalAccept + r.totalContest;
      storeHeader.setTotalAccept(totalAccept);
      storeHeader.setTotalReferences(r.totalReference);
      storeHeader.setTotalReprove(r.totalReject);
      storeHeader.setTotalContest(r.totalContest);
      storeHeader.setRefPend(r.refpend);
      storeHeader.setRefAccept(r.refAccept);
      storeHeader.setRefEpired(r.refExpired);
      storeHeader.setSaldo(r.saldo);
    });
  }

  Future<void> getSuppliersByReference(int referenceId) async {
    store.setSuppliers(_getSuppliersByReference(referenceId));
  }

  Future<void> refreshValues() async {
    store.startLoading();
    await getValuesHeader();
    await getReferences();
    store.stopLoading();
  }

  Future<void> applyFilter(int status) async {
    store.startLoading();
    var references = store.state.references;

    var listfiltered = await _getReferencesShop(status);
    listfiltered.fold((l) => null, (r) => references = r);
    /*if (status == 0) {
      listfiltered =
          references.where((x) => x.status == status || x.status == 3).toList();
    }*/
    store.setReferencesFiltered(references);
    store.stopLoading();
  }

  Future<void> getReferences() async {
    var filter = store.state.filterType;
    var result = _getReferencesShop(filter);
    store.setReferences(result);
  }

  Future<void> deleteReference(int referenceId) async {
    var result = await _deleteReference(referenceId);
    var success = false;

    result.fold((l) => success = false, (r) => success = true);

    if (success) {
      asuka.showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Text("Indicação excluída com sucesso"),
      ));
      getReferences();
      getValuesHeader();
    } else {
      asuka.showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text("Indicação já em andamento não pode ser excluída."),
      ));
    }
  }
}
