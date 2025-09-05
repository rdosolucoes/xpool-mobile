import 'package:dartz/dartz.dart';
import 'package:mobx_triple/mobx_triple.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../partnership_shop/domain/entities/supplier_entity.dart';
import '../../domain/entities/reference_shop_entity.dart';
import '../view_model/home_view_model.dart';

class HomeShopStore extends MobXStore<Failure, HomeVM> {
  HomeShopStore() : super(HomeVM());

  void setSuppliers(Future<Either<Failure, List<SupplierEntity>>> value) async {
    //setLoading(true);
    var result = await value;

    result.fold(
      setError,
      (r) {
        var newState = state.copyWith(suppliers: r);
        setLoading(false);
        update(newState);
      },
    );
    //setLoading(false);
  }

  void setReferences(
      Future<Either<Failure, List<ReferenceShopEntity>>> value) async {
    setLoading(true);
    var result = await value;

    result.fold(
      setError,
      (r) {
        var newState = state.copyWith(references: r);
        var status = state.filterType;

        if (state.filterType == 0) status = 3;

        setReferencesFiltered(r
            .where((x) => x.status == state.filterType || x.status == status)
            .toList());
        update(newState);

        var sumActives = 0;
        var listActives =
            r.where((x) => x.status == 0 || x.status == 3).toList();
        for (var e in listActives) {
          sumActives += e.totalReference;
        }
        setTotalActive(sumActives);

        var sumComplete = 0;
        var listCompletes = r.where((x) => x.status == 1).toList();
        for (var e in listCompletes) {
          sumComplete += e.totalReference;
        }
        setTotalComplete(sumComplete);

        var sumExpired = 0;
        var listExpired = r.where((x) => x.status == 2).toList();
        for (var e in listExpired) {
          sumExpired += e.totalReference;
        }
        setTotalExpired(sumExpired);

        setLoading(false);
      },
    );

    setLoading(false);
  }

  void setReferencesFiltered(List<ReferenceShopEntity> value) async {
    setLoading(true);
    var result = await value;
    var newState = state.copyWith(referencesFiltered: result);
    update(newState);
    setLoading(false);
  }

  void setFilterType(int v) {
    var newState = state.copyWith(filterType: v);
    update(newState);
  }

  void setTotalActive(int v) {
    var newState = state.copyWith(totalActive: v);
    update(newState);
  }

  void setTotalComplete(int v) {
    var newState = state.copyWith(totalComplete: v);
    update(newState);
  }

  void setTotalExpired(int v) {
    var newState = state.copyWith(totalExpired: v);
    update(newState);
  }

  void startLoading() {
    setLoading(true);
  }

  void stopLoading() {
    setLoading(false);
  }
}
