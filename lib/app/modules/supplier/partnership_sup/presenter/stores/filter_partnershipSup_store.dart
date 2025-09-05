import 'package:dartz/dartz.dart';
import 'package:mobx_triple/mobx_triple.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/dropdown_model.dart';
import '../../../../../../shared/needs/domain/entity/need_entity.dart';
import '../../domain/entities/filter_partnershipSup_entity.dart';

class FilterPartnershipSupStore
    extends MobXStore<Failure, FilterPartnershipSupEntity> {
  FilterPartnershipSupStore()
      : super(FilterPartnershipSupEntity(filterneeds: [], needs: []));

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

  void addNeed(int id) {
    state.filterneeds.add(id);
    var newState = state.copyWith(filterneeds: state.filterneeds);
    execute(() async => newState);
  }

  void removeNeed(int id) {
    state.filterneeds.removeWhere((value) => value == id);
    var newState = state.copyWith(filterneeds: state.filterneeds);
    execute(() async => newState);
  }

  bool existNeed(int id) {
    var index = state.filterneeds.indexWhere((value) => value == id);
    return (index != -1);
  }

  void setCity(DropdownModel? v) {
    var newState = state.copyWith(city: v);
    update(newState);
  }

  // ignore: avoid_positional_boolean_parameters
  void setShowPartners(bool v) {
    var newState = state.copyWith(showPartners: v);
    update(newState);
  }
}
