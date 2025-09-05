import 'package:dartz/dartz.dart';
import 'package:mobx_triple/mobx_triple.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../domain/entities/myreference_sup_entity.dart';
import '../view_models/my_reference_sup_view_model.dart';

class MyReferenceSupStore extends MobXStore<Failure, MyReferenceVM> {
  MyReferenceSupStore() : super(MyReferenceVM());

  void setFilter(String value) {
    var newState = state.copyWith(filter: value);
    execute(() async => newState);
  }

  void setReferences(
      Future<Either<Failure, List<MyReferenceSupEntity>>> value) async {
    setLoading(true);
    var result = await value;

    result.fold(
      setError,
      (r) {
        var newState = state.copyWith(references: r);
        update(newState);
      },
    );
    setLoading(false);
  }
}
