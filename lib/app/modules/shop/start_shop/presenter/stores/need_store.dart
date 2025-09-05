import 'package:dartz/dartz.dart';
import 'package:mobx_triple/mobx_triple.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/needs/domain/entity/need_entity.dart';
import '../../../reference_shop/presenter/view_models/need_view_model.dart';

class NeedStore extends MobXStore<Failure, NeedVM> {
  NeedStore() : super(NeedVM());

  void setNeeds(Future<Either<Failure, List<NeedEntity>>> value) async {
    setLoading(true);
    var result = await value;

    result.fold(
      setError,
      (r) {
        var newState = state.copyWith(needs: r);
        update(newState);
      },
    );
    setLoading(false);
  }
}
