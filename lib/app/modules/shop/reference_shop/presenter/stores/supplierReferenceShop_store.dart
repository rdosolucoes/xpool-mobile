import 'package:dartz/dartz.dart';
import 'package:mobx_triple/mobx_triple.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../domain/entities/supplier_reference_entity.dart';
import '../view_models/supplier_view_model.dart';

class SupplierReferenceShopStore extends MobXStore<Failure, SupplierVM> {
  SupplierReferenceShopStore() : super(SupplierVM());

  void setFilter(String value) {
    var newState = state.copyWith(filter: value);
    execute(() async => newState);
  }

  void setCheck(int index, value) {
    var suppliers = state.supplierFiltered;
    suppliers[index].checked = value;
    var newState = state.copyWith(suppliers: suppliers);
    update(newState);
  }

  SupplierReferenceEntity getSupplier(int index) {
    return state.supplierFiltered[index];
  }

  void setSuppliers(
      Future<Either<Failure, List<SupplierReferenceEntity>>> value) async {
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
}
