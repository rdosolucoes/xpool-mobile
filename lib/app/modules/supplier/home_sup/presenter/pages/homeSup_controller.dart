import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../shared/auth/stores/auth_store.dart';
import '../../../../../../shared/components/loading_progress_indicator/loading_progress_indicator_widget.dart';
import '../../domain/usecases/interfaces/accept_reference_sup_interface.dart';
import '../../domain/usecases/interfaces/get_partners_sup_interface.dart';
import '../../domain/usecases/interfaces/get_references_sup_interface.dart';
import '../../domain/usecases/interfaces/get_values_headers_sup_interface.dart';
import '../../domain/usecases/interfaces/reject_reference_sup_interface.dart';
import '../stores/headerSup_store.dart';
import '../stores/homeSup_store.dart';

class HomeSupController {
  final HomeSupStore store;
  final AuthStore authStore;
  final HeaderSupStore storeHeader;
  final IGetPartnersSup _getPartnersSup;
  final IGetReferencesSup _getReferencesSup;
  final IAcceptReferenceSup _acceptReferencesSup;
  final IRejectReferenceSup _rejectReferencesSup;
  final IGetValuesHeaderSup _getValuesHeader;

  HomeSupController(
      this.store,
      this.authStore,
      this.storeHeader,
      this._getPartnersSup,
      this._getReferencesSup,
      this._acceptReferencesSup,
      this._rejectReferencesSup,
      this._getValuesHeader);

  Future<void> getSuppliers() async {
    store.setSuppliers(_getPartnersSup());
  }

  Future<void> getReferences() async {
    store.setReferences(_getReferencesSup());
  }

  Future<void> getValuesHeader() async {
    var result = await _getValuesHeader.call();

    result.fold((l) => null, (r) {
      storeHeader.setTotalAccept(r.totalAccept);
      storeHeader.setTotalReferences(r.totalReference);
      storeHeader.setTotalReprove(r.totalReject);
      storeHeader.setCardDefault(r.cardDefault);
      storeHeader.setRefValue(r.refValue);
    });
  }

  Future<void> refreshValues() async {
    store.startLoading();
    await getValuesHeader();
    await getReferences();
    store.stopLoading();
  }

  Future<void> acceptReference(int referenceId) async {
    var overlay = OverlayEntry(
      builder: (context) {
        return LoadingProgressIndicatorWidget(
          isCustom: true,
        );
      },
    );
    asuka.addOverlay(overlay);

    await Future.delayed(Duration(seconds: 3));

    var result = await _acceptReferencesSup.call(referenceId);
    overlay.remove();
    result.fold((l) {
      var msg = l.message ?? "Essa indicação não esta mais disponível.";
      asuka.showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(msg),
      ));
    }, (r) {
      asuka.showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Text("Indicação aceita com sucesso"),
      ));
      refreshValues();
      Modular.to.navigate('/startSup/myReferenceSup');
    });
  }

  Future<void> rejectReference(int referenceId) async {
    var overlay = OverlayEntry(
      builder: (context) {
        return LoadingProgressIndicatorWidget(
          isCustom: true,
        );
      },
    );
    asuka.addOverlay(overlay);

    await Future.delayed(Duration(seconds: 3));

    var result = await _rejectReferencesSup.call(referenceId);
    overlay.remove();
    result.fold((l) {
      asuka.showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text("Essa indicação não esta mais disponível."),
      ));
    }, (r) {
      asuka.showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Text("Indicação rejeitada com sucesso"),
      ));
      refreshValues();
    });
  }
}
