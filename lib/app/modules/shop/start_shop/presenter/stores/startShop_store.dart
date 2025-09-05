import 'package:mobx_triple/mobx_triple.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../domain/entity/tab_menu_entity.dart';

class StartShopStore extends MobXStore<Failure, TabMenuEntity> {
  StartShopStore() : super(TabMenuEntity());

  void setCurrentTabIndex(int v) {
    var newState = state.copyWith(index: v);
    update(newState);
  }

  void setNotifyCount(int v) {
    var newState = state.copyWith(notifyCount: v);
    update(newState);
  }

  int getNotifyCount() {
    return state.notifyCount;
  }
}
