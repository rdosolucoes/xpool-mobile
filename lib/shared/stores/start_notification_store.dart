import 'package:mobx_triple/mobx_triple.dart';

import '../helpers/errors.dart';

class StartNotificationStore extends MobXStore<Failure, int> {
  StartNotificationStore() : super(0);

  void setCountNotification(int v) {
    update(1);
  }
}
