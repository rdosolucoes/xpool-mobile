import 'dart:convert';

import '../../domain/entities/reference_shop_entity.dart';

class ReferenceShopModel extends ReferenceShopEntity {
  ReferenceShopModel(
      {int id = 0,
      String dateHour = '',
      String need = '',
      String customerName = '',
      String iconNeed = '',
      String localMainText = '',
      String localSecondaryText = '',
      String latitude = '',
      String longitude = '',
      int totalReference = 0,
      int totalAccept = 0,
      int totalReject = 0,
      int totalContest = 0,
      int status = 0,
      String employee = "",
      String? messageError,
      bool? success})
      : super(
            id: id,
            dateHour: dateHour,
            need: need,
            customerName: customerName,
            iconNeed: iconNeed,
            localMainText: localMainText,
            localSecondaryText: localSecondaryText,
            latitude: latitude,
            longitude: longitude,
            totalReference: totalReference,
            totalAccept: totalAccept,
            totalReject: totalReject,
            totalContest: totalContest,
            status: status,
            employee: employee,
            messageError: messageError,
            success: success);

  factory ReferenceShopModel.fromMap(Map<String, dynamic>? json) {
    if (json == null) return ReferenceShopModel();

    return ReferenceShopModel(
      id: json['id'] ?? '',
      dateHour: json['dateHour'] ?? '',
      need: json['need'] ?? '',
      customerName: json['customerName'] ?? '',
      localMainText: json['localMainText'] ?? '',
      localSecondaryText: json['localSecondaryText'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      iconNeed: json['iconNeed'] ?? '',
      totalAccept: json['totalAccept'] ?? '',
      totalReference: json['totalReference'] ?? '',
      totalReject: json['totalReject'] ?? '',
      totalContest: json['totalContest'] ?? '',
      status: json['status'] ?? '',
      employee: json['employee'] ?? '',
    );
  }

  factory ReferenceShopModel.fromJson(String source) =>
      ReferenceShopModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dateHour': dateHour,
      'need': need,
      'customerName': customerName,
      'localMainText': localMainText,
      'localSecondaryText': localSecondaryText,
      'latitude': latitude,
      'longitude': longitude,
      'iconNeed': iconNeed,
      'totalAccept': totalAccept,
      'totalReference': totalReference,
      'totalReject': totalReject,
      'totalContest': totalContest,
      'status': status,
      'employee': employee
    };
  }

  String toJson() => json.encode(toMap());
}
