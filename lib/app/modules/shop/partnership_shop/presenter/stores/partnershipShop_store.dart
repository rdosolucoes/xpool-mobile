import 'package:dartz/dartz.dart';
import 'package:mobx_triple/mobx_triple.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../domain/entities/supplier_entity.dart';
import '../view_models/supplier_view_model.dart';

class PartnershipShopStore extends MobXStore<Failure, SupplierVM> {
  PartnershipShopStore() : super(SupplierVM());

  void setFilter(String value) {
    var newState = state.copyWith(filter: value);
    execute(() async => newState);
  }

  void setStatus(int index) {
    var suppliers = state.supplierFiltered;
    suppliers[index].status = suppliers[index].status == -1 ? 0 : -1;
    var newState = state.copyWith(suppliers: suppliers);
    update(newState);
  }

  void setSuppliers(Future<Either<Failure, List<SupplierEntity>>> value) async {
    setLoading(true);
    var result = await value;

    result.fold(
      setError,
      (r) {
        var newState = state.copyWith(suppliers: r);
        update(newState);
      },
    );
    setLoading(false);
  }

  void startLoading() {
    setLoading(true);
  }

  void stopLoading() {
    setLoading(false);
  }
}
