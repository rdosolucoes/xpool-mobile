import 'package:flutter/foundation.dart';

import '../../domain/entities/notificationSup_entity.dart';

@immutable
class NotificationVM {
  final List<NotificationSupEntity> notifications;
  final String filter;
  final int status;

  List<NotificationSupEntity> get notificationFiltered => notifications
      .where((e) => e.name!.contains(filter.toUpperCase()))
      .toList();

  NotificationVM(
      {this.notifications = const <NotificationSupEntity>[],
      this.filter = '',
      this.status = 0});

  NotificationVM copyWith({
    List<NotificationSupEntity>? notifications,
    String? filter,
    int? status,
  }) {
    return NotificationVM(
      notifications: notifications ?? this.notifications,
      filter: filter ?? this.filter,
      status: status ?? this.status,
    );
  }
}
