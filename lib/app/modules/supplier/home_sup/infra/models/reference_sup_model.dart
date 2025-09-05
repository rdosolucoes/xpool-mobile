import 'dart:convert';

import '../../../../../../shared/helpers/consts.dart';
import '../../domain/entities/reference_Sup_entity.dart';

class ReferenceSupModel extends ReferenceSupEntity {
  ReferenceSupModel(
      {int id = 0,
      String userOrig = '',
      String urlLogo = imageDefault,
      String dateHour = '',
      String need = '',
      String iconNeed = '',
      String localMainText = '',
      String localSecondaryText = '',
      String latitude = '',
      String longitude = '',
      int totalReference = 0,
      int totalAccept = 0,
      int totalReject = 0,
      int status = 0,
      String description = '',
      String? messageError,
      bool? success})
      : super(
            id: id,
            userOrig: userOrig,
            urlLogo: urlLogo,
            dateHour: dateHour,
            need: need,
            iconNeed: iconNeed,
            localMainText: localMainText,
            localSecondaryText: localSecondaryText,
            latitude: latitude,
            longitude: longitude,
            totalReference: totalReference,
            totalAccept: totalAccept,
            totalReject: totalReject,
            status: status,
            description: description,
            messageError: messageError,
            success: success);

  factory ReferenceSupModel.fromMap(Map<String, dynamic>? json) {
    if (json == null) return ReferenceSupModel();

    return ReferenceSupModel(
      id: json['id'] ?? '',
      userOrig: json['userOrig'] ?? '',
      urlLogo: json['urlLogo'] ?? imageDefault,
      dateHour: json['dateHour'] ?? '',
      need: json['need'] ?? '',
      iconNeed: json['iconNeed'] ?? '',
      localMainText: json['localMainText'] ?? '',
      localSecondaryText: json['localSecondaryText'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      description: json['description'] ?? '',
      totalAccept: json['totalAccept'] ?? '',
      totalReference: json['totalReference'] ?? '',
      totalReject: json['totalReject'] ?? '',
    );
  }

  factory ReferenceSupModel.fromJson(String source) =>
      ReferenceSupModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userOrig': userOrig,
      'urlLogo': urlLogo,
      'dateHour': dateHour,
      'need': need,
      'localMainText': localMainText,
      'localSecondaryText': localSecondaryText,
      'latitude': latitude,
      'longitude': longitude,
      'iconNeed': iconNeed,
      'description': description,
      'totalAccept': totalAccept,
      'totalReference': totalReference,
      'totalReject': totalReject,
    };
  }

  String toJson() => json.encode(toMap());
}
