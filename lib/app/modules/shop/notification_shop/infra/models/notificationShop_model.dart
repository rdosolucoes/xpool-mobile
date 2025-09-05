import 'dart:convert';

import '../../../../../../shared/helpers/consts.dart';
import '../../../../../../shared/helpers/enum.dart';
import '../../domain/entities/notificationShop_entity.dart';

class NotificationShopModel extends NotificationShopEntity {
  NotificationShopModel({
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

  factory NotificationShopModel.fromMap(Map<String, dynamic>? json) {
    if (json == null) return NotificationShopModel();

    return NotificationShopModel(
        id: json['id'] ?? '',
        type: ETypeNotification.values[json['type']],
        status: json['status'],
        name: json['name'] ?? '',
        message: json['message'] ?? '',
        cityState: json['cityState'] ?? '',
        dateHour: json['dateHour'] ?? '',
        photo: json['photo'] ?? imageDefaultSup);
  }

  factory NotificationShopModel.fromJson(String source) =>
      NotificationShopModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'status': status,
      'name': name,
      'message': message,
      'cityState': cityState,
      'dateHour': dateHour,
      "photo": photo,
    };
  }

  String toJson() => json.encode(toMap());
}
