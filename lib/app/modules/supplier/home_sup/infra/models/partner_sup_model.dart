import 'dart:convert';

import '../../../../../../shared/helpers/consts.dart';
import '../../domain/entities/partner_sup_entity.dart';

class PartnerSupModel extends PartnerSupEntity {
  PartnerSupModel(
      {int id = 0,
      String name = '',
      String city = '',
      String photo = '',
      int status = 0,
      String? messageError,
      bool? success})
      : super(
            id: id,
            name: name,
            city: city,
            photo: photo,
            status: status,
            messageError: messageError,
            success: success);

  factory PartnerSupModel.fromMap(Map<String, dynamic>? json) {
    if (json == null) return PartnerSupModel();

    return PartnerSupModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      city: json['city'] ?? '',
      photo: json['photo'] ?? imageDefault,
      status: json['status'] ?? '',
    );
  }

  factory PartnerSupModel.fromJson(String source) =>
      PartnerSupModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'city': city,
      'status': status,
      'photo': photo
    };
  }

  String toJson() => json.encode(toMap());
}
