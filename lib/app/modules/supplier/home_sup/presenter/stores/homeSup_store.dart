import 'package:dartz/dartz.dart';
import 'package:mobx_triple/mobx_triple.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../domain/entities/partner_sup_entity.dart';
import '../../domain/entities/reference_sup_entity.dart';
import '../view_model/home_view_model.dart';

class HomeSupStore extends MobXStore<Failure, HomeSupVM> {
  HomeSupStore() : super(HomeSupVM());

  void setSuppliers(
      Future<Either<Failure, List<PartnerSupEntity>>> value) async {
    setLoading(true);
    var result = await value;

    result.fold(
      setError,
      (r) {
        var newState = state.copyWith(suppliers: r);
        setLoading(false);
        update(newState);
      },
    );
    setLoading(false);
  }

  void setReferences(
      Future<Either<Failure, List<ReferenceSupEntity>>> value) async {
    //setLoading(true);
    var result = await value;

    result.fold(
      setError,
      (r) {
        var newState = state.copyWith(references: r);
        setLoading(false);
        update(newState);
      },
    );
    //setLoading(false);
  }

  void startLoading() {
    setLoading(true);
  }

  void stopLoading() {
    setLoading(false);
  }
}
