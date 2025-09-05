import 'dart:convert';

import '../../domain/entities/reference_entity.dart';

class ReferenceModel extends ReferenceEntity {
  final String mainText;
  final String secondaryText;
  final String latitude;
  final String longitude;

  ReferenceModel(
      {List<int>? supIds,
      String name = '',
      this.mainText = '',
      this.secondaryText = '',
      this.latitude = '',
      this.longitude = '',
      String phone = '',
      String description = '',
      int needId = 0,
      String? messageError,
      bool? success})
      : super(
            supIds: supIds,
            name: name,
            phone: phone,
            description: description,
            needId: needId,
            messageError: messageError,
            success: success);

  factory ReferenceModel.fromMap(Map<String, dynamic>? json) {
    if (json == null) return ReferenceModel();

    return ReferenceModel(
      supIds: json['supIds'] ?? '',
      name: json['name'] ?? '',
      mainText: json['mainText'] ?? '',
      secondaryText: json['secondaryText'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      phone: json['phone'] ?? '',
      description: json['description'] ?? '',
      needId: json['needId'] ?? '',
    );
  }

  factory ReferenceModel.fromJson(String source) =>
      ReferenceModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'supIds': supIds,
      'name': name,
      'mainText': mainText,
      'secondaryText': secondaryText,
      'latitude': latitude,
      'longitude': longitude,
      'phone': phone,
      'description': description,
      'needId': needId
    };
  }

  String toJson() => json.encode(toMap());
}
