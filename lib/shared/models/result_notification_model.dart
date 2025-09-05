import 'dart:convert';

import 'result_model.dart';

class ResultNotificationModel extends ResultModel {
  final String title;
  final String content;
  final List<String>? playerIds;
  final bool success;
  final String? message;

  ResultNotificationModel({
    this.title = "",
    this.content = "",
    this.playerIds = const [],
    required this.success,
    this.message,
  }) : super(success: success, message: message);

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'playerIds': playerIds,
      'success': success,
      'message': message,
    };
  }

  factory ResultNotificationModel.fromMap(Map<String, dynamic> map) {
    dynamic playerIds;
    if (map['playerIds'] != null) {
      playerIds = map['playerIds'];
      playerIds = playerIds.cast<String>();
    } else {
      playerIds = null;
    }

    return ResultNotificationModel(
      content: map['content'],
      title: map['title'],
      playerIds: playerIds,
      success: map['success'],
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultNotificationModel.fromJson(String source) =>
      ResultNotificationModel.fromMap(json.decode(source));
}
