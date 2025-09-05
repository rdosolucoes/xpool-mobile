import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';

import '../../../../../../shared/components/loading_progress_indicator/loading_progress_indicator_widget.dart';
import '../../domain/entities/myreference_sup_entity.dart';
import '../../domain/usecases/interfaces/create_dispute_interface.dart';
import '../../domain/usecases/interfaces/get_my_references_interface.dart';
import '../../domain/usecases/interfaces/set_done_deal_interface.dart';
import '../../infra/models/dispute_sup_model.dart';
import '../stores/my_reference_sup_store.dart';

class MyReferenceSupController {
  final IGetMyReferences _getMyReferences;
  final ISetDoneDeal _setDoneDeal;
  final ICreateDispute _createDispute;
  final MyReferenceSupStore store;

  MyReferenceSupController(
    this._getMyReferences,
    this._createDispute,
    this._setDoneDeal,
    this.store,
  );

  Future<void> getReferences({int offset = 0, int limit = 10}) async {
    store.setReferences(_getMyReferences(offset, limit));
  }

  Future<List<MyReferenceSupEntity>> getReferencesPage(
      int offset, int limit) async {
    var references = <MyReferenceSupEntity>[];

    var result = await _getMyReferences(offset, limit);

    result.fold((l) => null, (r) => references = r);

    return references;
  }

  Future<void> setDoneDeal(int value, int referenceId) async {
    await _setDoneDeal(value, referenceId);
  }

  Future<void> createDispute(int referenceId, String message) async {
    var overlay = OverlayEntry(
      builder: (context) {
        return LoadingProgressIndicatorWidget(
          isCustom: true,
        );
      },
    );
    asuka.addOverlay(overlay);

    await Future.delayed(Duration(seconds: 3));

    var model = DisputeModel(referenceId: referenceId, message: message);
    var result = await _createDispute.call(model);

    overlay.remove();
    result.fold((l) {
      asuka.showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text("Falha ao criar Contestação"),
      ));
    }, (r) {
      asuka.showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Text("Constestação criada com Sucesso"),
      ));
      getReferences();
    });
  }
}
