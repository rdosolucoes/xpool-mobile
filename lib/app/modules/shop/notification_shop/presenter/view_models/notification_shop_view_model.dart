import 'package:flutter/foundation.dart';

import '../../domain/entities/notificationShop_entity.dart';

@immutable
class NotificationShopVM {
  final List<NotificationShopEntity> notifications;
  final String filter;
  final int status;

  List<NotificationShopEntity> get notificationFiltered => notifications
      .where((e) => e.name!.contains(filter.toUpperCase()))
      .toList();

  NotificationShopVM(
      {this.notifications = const <NotificationShopEntity>[],
      this.filter = '',
      this.status = 0});

  NotificationShopVM copyWith({
    List<NotificationShopEntity>? notifications,
    String? filter,
    int? status,
  }) {
    return NotificationShopVM(
      notifications: notifications ?? this.notifications,
      filter: filter ?? this.filter,
      status: status ?? this.status,
    );
  }
}
