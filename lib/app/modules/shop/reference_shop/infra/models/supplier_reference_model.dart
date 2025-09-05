import 'dart:convert';

import '../../../../../../shared/helpers/consts.dart';
import '../../domain/entities/supplier_reference_entity.dart';

class SupplierReferenceModel extends SupplierReferenceEntity {
  SupplierReferenceModel(
      {int id = 0,
      String name = '',
      String city = '',
      String photo = '',
      int status = 0,
      int totalReference = 0,
      int totalAccept = 0,
      int totalReject = 0,
      String recipientId = '',
      String? messageError,
      bool? success})
      : super(
            id: id,
            name: name,
            city: city,
            photo: photo,
            status: status,
            totalReference: totalReference,
            totalAccept: totalAccept,
            totalReject: totalReject,
            recipientId: recipientId,
            messageError: messageError,
            success: success);

  factory SupplierReferenceModel.fromMap(Map<String, dynamic>? json) {
    if (json == null) return SupplierReferenceModel();

    return SupplierReferenceModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      city: json['city'] ?? '',
      photo: json['photo'] ?? imageDefaultSup,
      status: json['status'] ?? '',
      totalReference: json['totalReference'] ?? '',
      totalAccept: json['totalAccept'] ?? '',
      totalReject: json['totalReject'] ?? '',
      recipientId: json['recipientId'] ?? '',
    );
  }

  factory SupplierReferenceModel.fromJson(String source) =>
      SupplierReferenceModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'city': city,
      'status': status,
      'photo': photo,
      'totalReference': totalReference,
      'totalAccept': totalAccept,
      'totalReject': totalReject,
      'recipientId': recipientId
    };
  }

  String toJson() => json.encode(toMap());
}
