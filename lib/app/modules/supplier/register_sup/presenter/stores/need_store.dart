import 'package:dartz/dartz.dart';
import 'package:mobx_triple/mobx_triple.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/needs/domain/entity/need_entity.dart';
import '../view_models/need_view_model.dart';

class NeedStore extends MobXStore<Failure, NeedVM> {
  NeedStore() : super(NeedVM());

  bool existNeed(int id) {
    var index = state.addedNeeds.indexWhere((value) => value == id);
    return (index != -1);
  }

  void addNeed(int id) {
    state.addedNeeds.add(id);
    var newState = state.copyWith(addedNeeds: state.addedNeeds);
    execute(() async => newState);
  }

  void removeNeed(int id) {
    state.addedNeeds.removeWhere((value) => value == id);
    var newState = state.copyWith(addedNeeds: state.addedNeeds);
    execute(() async => newState);
  }

  void setNeeds(Future<Either<Failure, List<NeedEntity>>> value) async {
    setLoading(true);
    var result = await value;

    result.fold(
      setError,
      (r) {
        var newState = state.copyWith(needs: r, addedNeeds: []);
        update(newState);
      },
    );
    setLoading(false);
  }
}
