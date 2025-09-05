import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';

import '../../../../../../shared/auth/stores/auth_store.dart';
import '../../../../../../shared/components/loading_progress_indicator/loading_progress_indicator_widget.dart';
import '../../../../../../shared/models/dropdown_model.dart';
import '../../domain/usecases/get_cities_sup.dart';
import '../../domain/usecases/interfaces/break_partner_supplier_interface.dart';
import '../../domain/usecases/interfaces/cancel_invite_supplier_interface.dart';
import '../../domain/usecases/interfaces/create_invite_supplier_interface.dart';
import '../../domain/usecases/interfaces/get_all_suppliers_interface.dart';
import '../../domain/usecases/interfaces/get_needs_interface.dart';
import '../stores/filter_partnershipShop_store.dart';
import '../stores/partnershipShop_store.dart';

class PartnershipShopController {
  final IGetAllSuppliers _getAllSuppliers;
  final IGetNeeds _getNeeds;
  final ICreateInviteSupplier _createInviteSupplier;
  final ICancelInviteSupplier _cancelInviteSupplier;
  final IBreakPartnerSupplier _breakPartnerSupplier;
  final PartnershipShopStore store;
  final FilterPartnershipShopStore filterStore;
  final GetCitiesSup _getCitiesSup;
  final AuthStore _authStore;

  List<DropdownModel> cities = <DropdownModel>[];
  DropdownModel cityMain = DropdownModel();

  PartnershipShopController(
      this._getAllSuppliers,
      this._createInviteSupplier,
      this._cancelInviteSupplier,
      this._breakPartnerSupplier,
      this.store,
      this.filterStore,
      this._getNeeds,
      this._getCitiesSup,
      this._authStore);

  Future<void> getSuppliers() async {
    store.setSuppliers(_getAllSuppliers(filterStore.state));
  }

  Future<void> getNeeds() async {
    filterStore.setNeeds(_getNeeds());
  }

  Future<void> getCities() async {
    var citiesResult = await _getCitiesSup.call();
    citiesResult.fold((l) => null, (r) => cities = r);

    if (_authStore.state.cityId != null && cities.length > 0) {
      var cityId = _authStore.state.cityId!;
      if (cities.any((x) => x.id == cityId)) {
        cityMain = cities.singleWhere((x) => x.id == cityId);
      }
    }
    filterStore.setCity(cityMain);
  }

  String getShopName() {
    return _authStore.state.name ?? "";
  }

  Future<List<DropdownModel>> getCitiesSup(String? s) async {
    return cities;
  }

  Future<void> refresh() async {
    store.startLoading();
    await getCities();
    getSuppliers();
    getNeeds();
    store.stopLoading();
  }

  Future<void> createInvite(int userId, int index) async {
    var result = await _createInviteSupplier.call(userId);

    result.fold(
      (l) {
        var msgError = "Falha ao realizar o convite.";

        if (l.message != null) {
          msgError = l.message!;
        }

        asuka.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(msgError),
        ));
        store.setStatus(index);
      },
      (r) {},
    );
  }

  void setCity(DropdownModel? v) {
    filterStore.setCity(v);
    getSuppliers();
  }

  Future<void> cancelInvite(int userId, int index) async {
    var result = await _cancelInviteSupplier.call(userId);

    result.fold(
      (l) {
        var msgError = "Falha ao cancelar o convite.";

        if (l.message != null) {
          msgError = l.message!;
        }

        asuka.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(msgError),
        ));
        store.setStatus(index);
      },
      (r) {},
    );
  }

  Future<void> breakPartner(int userId) async {
    var overlay = OverlayEntry(
      builder: (context) {
        return LoadingProgressIndicatorWidget(
          isCustom: true,
        );
      },
    );
    asuka.addOverlay(overlay);

    await Future.delayed(Duration(seconds: 2));

    var result = await _breakPartnerSupplier.call(userId);

    overlay.remove();

    result.fold(
      (l) {
        var msgError = "Falha ao desfazer parceria.";

        if (l.message != null) {
          msgError = l.message!;
        }

        asuka.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(msgError),
        ));
      },
      (r) {
        asuka.showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text("Parceria desfeita com Sucesso"),
        ));
        getSuppliers();
      },
    );
  }
}
