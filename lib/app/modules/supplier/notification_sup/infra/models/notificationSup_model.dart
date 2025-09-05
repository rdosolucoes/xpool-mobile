import 'dart:convert';

import '../../../../../../shared/helpers/consts.dart';

import '../../../../../../shared/helpers/enum.dart';
import '../../domain/entities/notificationSup_entity.dart';

class NotificationSupModel extends NotificationSupEntity {
  NotificationSupModel({
    int? id,
    ETypeNotification? type,
    String? name,
    String? message,
    String? cityState,
    int status = 0,
    String? dateHour,
    String? photo,
  }) : super(
            id: id,
            type: type,
            status: status,
            name: name,
            message: message,
            cityState: cityState,
            dateHour: dateHour,
            photo: photo);

  factory NotificationSupModel.fromMap(Map<String, dynamic>? json) {
    if (json == null) return NotificationSupModel();

    return NotificationSupModel(
        id: json['id'] ?? '',
        type: ETypeNotification.values[json['type']],
        status: json['status'],
        name: json['name'] ?? '',
        message: json['message'] ?? '',
        cityState: json['cityState'] ?? '',
        dateHour: json['dateHour'] ?? '',
        photo: json['photo'] ?? imageDefault);
  }

  factory NotificationSupModel.fromJson(String source) =>
      NotificationSupModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'status': status,
      'name': name,
      'message': message,
      'cityState': cityState,
      'dateHour': dateHour,
      'photo': photo
    };
  }

  String toJson() => json.encode(toMap());
}
