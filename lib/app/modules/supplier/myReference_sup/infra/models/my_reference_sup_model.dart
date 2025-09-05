import 'dart:convert';

import '../../domain/entities/myreference_sup_entity.dart';

class MyReferenceSupModel extends MyReferenceSupEntity {
  MyReferenceSupModel(
      {int id = 0,
      String shopLogo = '',
      String shopName = '',
      String customerName = '',
      String customerPhone = '',
      String dateHour = '',
      String needDescription = '',
      String iconNeed = '',
      String localMainText = '',
      String localSecondaryText = '',
      String latitude = '',
      String longitude = '',
      String taskDescription = '',
      int status = 0,
      String reply = '',
      int doneDeal = 0,
      String? messageError,
      bool? success})
      : super(
            id: id,
            shopLogo: shopLogo,
            shopName: shopName,
            customerName: customerName,
            customerPhone: customerPhone,
            dateHour: dateHour,
            needDescription: needDescription,
            iconNeed: iconNeed,
            localMainText: localMainText,
            localSecondaryText: localSecondaryText,
            latitude: latitude,
            longitude: longitude,
            taskDescription: taskDescription,
            messageError: messageError,
            status: status,
            doneDeal: doneDeal,
            reply: reply,
            success: success);

  factory MyReferenceSupModel.fromMap(Map<String, dynamic>? json) {
    if (json == null) return MyReferenceSupModel();

    return MyReferenceSupModel(
      id: json['id'] ?? '',
      shopLogo: json['shopLogo'] ?? '',
      shopName: json['shopName'] ?? '',
      customerName: json['customerName'] ?? '',
      customerPhone: json['customerPhone'] ?? '',
      dateHour: json['dateHour'] ?? '',
      needDescription: json['needDescription'] ?? '',
      iconNeed: json['iconNeed'] ?? '',
      taskDescription: json['taskDescription'] ?? '',
      localMainText: json['localMainText'] ?? '',
      localSecondaryText: json['localSecondaryText'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      status: json['status'] ?? '',
      reply: json['reply'] ?? '',
      doneDeal: json['doneDeal'] ?? 0,
    );
  }

  factory MyReferenceSupModel.fromJson(String source) =>
      MyReferenceSupModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shopLogo': shopLogo,
      'shopName': shopName,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'dateHour': dateHour,
      'needDescription': needDescription,
      'iconNeed': iconNeed,
      'taskDescription': taskDescription,
      'localMainText': localMainText,
      'localSecondaryText': localSecondaryText,
      'latitude': latitude,
      'longitude': longitude,
      'status': status,
      'reply': reply,
      'doneDeal': doneDeal
    };
  }

  String toJson() => json.encode(toMap());
}
