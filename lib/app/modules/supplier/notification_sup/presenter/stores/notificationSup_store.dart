import 'package:dartz/dartz.dart';
import 'package:mobx_triple/mobx_triple.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../domain/entities/notificationSup_entity.dart';
import '../view_models/notification_view_model.dart';

class NotificationSupStore extends MobXStore<Failure, NotificationVM> {
  NotificationSupStore() : super(NotificationVM());

  void setFilter(String value) {
    var newState = state.copyWith(filter: value);
    execute(() async => newState);
  }

  void setStatus(int index, int value) {
    var notifications = state.notificationFiltered;
    notifications[index].status = value;
    var newState = state.copyWith(notifications: notifications);
    update(newState);
  }

  void setNotifications(
      Future<Either<Failure, List<NotificationSupEntity>>> value) async {
    setLoading(true);
    var result = await value;

    result.fold(
      setError,
      (r) {
        var newState = state.copyWith(notifications: r);
        update(newState);
      },
    );
    setLoading(false);
  }
}
