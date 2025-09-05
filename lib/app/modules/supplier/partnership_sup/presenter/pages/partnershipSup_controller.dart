import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';

import '../../../../../../shared/auth/stores/auth_store.dart';
import '../../../../../../shared/components/loading_progress_indicator/loading_progress_indicator_widget.dart';
import '../../../../../../shared/models/dropdown_model.dart';
import '../../domain/usecases/get_cities_shop.dart';
import '../../domain/usecases/interfaces/break_partner_shop_interface.dart';
import '../../domain/usecases/interfaces/cancel_invite_shop_interface.dart';
import '../../domain/usecases/interfaces/create_invite_shop_interface.dart';
import '../../domain/usecases/interfaces/get_all_shops_interface.dart';
import '../stores/filter_partnershipSup_store.dart';
import '../stores/partnershipSup_store.dart';

class PartnershipSupController {
  final IGetAllShops _getAllShops;
  final ICreateInviteShop _createInviteShop;
  final ICancelInviteShop _cancelInviteShop;
  final IBreakPartnerShop _breakPartnerShop;
  final PartnershipSupStore store;
  final FilterPartnershipSupStore filterStore;
  final GetCitiesShop _getCitiesShop;
  final AuthStore _authStore;

  List<DropdownModel> cities = <DropdownModel>[];
  DropdownModel? cityMain = DropdownModel();

  PartnershipSupController(
      this._getAllShops,
      this._createInviteShop,
      this._cancelInviteShop,
      this._breakPartnerShop,
      this.store,
      this.filterStore,
      this._getCitiesShop,
      this._authStore);

  Future<List<DropdownModel>> getCitiesShop(String? s) async {
    return cities;
  }

  Future<void> getCities() async {
    var citiesResult = await _getCitiesShop.call();
    citiesResult.fold((l) => null, (r) => cities = r);

    if (_authStore.state.cityId != null && cities.length > 0) {
      var cityId = _authStore.state.cityId!;

      if (cities.any((x) => x.id == cityId)) {
        cityMain = cities.singleWhere((x) => x.id == cityId);
      }
    }
    filterStore.setCity(cityMain);
  }

  Future<void> getShops() async {
    store.setShops(_getAllShops(filterStore.state));
  }

  Future<void> refresh() async {
    store.startLoading();
    await getCities();
    getShops();
    store.stopLoading();
  }

  String getSupName() {
    return _authStore.state.name ?? "";
  }

  Future<void> createInvite(int userId, int index) async {
    var result = await _createInviteShop.call(userId);

    result.fold(
      (l) {
        var msgError = "Falha ao criar o convite.";

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

  Future<void> cancelInvite(int userId, int index) async {
    var result = await _cancelInviteShop.call(userId);

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

    var result = await _breakPartnerShop.call(userId);

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
        getShops();
      },
    );
  }

  void setCity(DropdownModel? v) {
    if (v == null) v = DropdownModel();
    filterStore.setCity(v);
    getShops();
  }
}
