import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../shared/components/loading_progress_indicator/loading_progress_indicator_widget.dart';
import '../../domain/usecases/approve_dispute.dart';
import '../../domain/usecases/disapprove_dispute.dart';
import '../../domain/usecases/get_dispute.dart';
import '../stores/dispute_store.dart';

class DisputeController {
  final GetDispute _getDispute;
  final ApproveDispute _approveDispute;
  final DisapproveDispute _disapproveDispute;
  final DisputeStore store;

  DisputeController(this._getDispute, this._approveDispute,
      this._disapproveDispute, this.store);

  Future<void> getDispute(int supId, int referenceId) async {
    store.setDispute(await _getDispute.call(supId, referenceId));
  }

  Future<void> approveDispute(int disputeId) async {
    var overlay = OverlayEntry(
      builder: (context) {
        return LoadingProgressIndicatorWidget(
          isCustom: true,
        );
      },
    );
    asuka.addOverlay(overlay);

    await Future.delayed(Duration(seconds: 3));

    var result = await _approveDispute.call(disputeId);

    overlay.remove();

    result.fold((l) {
      asuka.showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text("Falha ao realizar aprovação"),
      ));
    }, (r) {
      asuka.showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Text("Contestação aprovada com sucesso"),
      ));

      Modular.to.pop();
    });
  }

  Future<void> disapproveDispute(int disputeId, String message) async {
    var overlay = OverlayEntry(
      builder: (context) {
        return LoadingProgressIndicatorWidget(
          isCustom: true,
        );
      },
    );
    asuka.addOverlay(overlay);

    var result = await _disapproveDispute.call(disputeId, message);

    overlay.remove();

    result.fold((l) {
      asuka.showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text("Falha ao realizar reprovação"),
      ));
    }, (r) {
      asuka.showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Text("Contestação reprovada com sucesso"),
      ));

      Modular.to.pop();
    });
  }

  bool hasValue() {
    return store.state.customerName != "";
  }
}
