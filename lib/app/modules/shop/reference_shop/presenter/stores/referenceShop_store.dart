import 'package:mobx_triple/mobx_triple.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/localization_model.dart';
import '../../domain/entities/reference_entity.dart';

class ReferenceShopStore extends MobXStore<Failure, ReferenceEntity> {
  ReferenceShopStore() : super(ReferenceEntity());

  void setLocalization(LocalizationModel? v) {
    var newState = state.copyWith(localization: v);
    update(newState);
  }

  void setName(String v) {
    var newState = state.copyWith(name: v);
    update(newState);
  }

  void setPhone(String v) {
    var newState = state.copyWith(phone: v);
    update(newState);
  }

  void setDescription(String v) {
    var newState = state.copyWith(description: v);
    update(newState);
  }

  void setNeed(int v) {
    var newState = state.copyWith(needId: v);
    update(newState);
  }

  void clearSupIds() {
    var newState = state.copyWith(supIds: []);
    update(newState);
  }

  void addSupId(int id) {
    var supIds = state.supIds;
    supIds!.add(id);
    var newState = state.copyWith(supIds: supIds);
    update(newState);
  }

  void removeSupId(int id) {
    var supIds = state.supIds;
    supIds!.remove(id);
    var newState = state.copyWith(supIds: supIds);
    update(newState);
  }
}
