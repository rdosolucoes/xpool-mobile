import 'dart:convert';

import '../../../../../../shared/helpers/consts.dart';
import '../../domain/entities/partner_shop_entity.dart';

class PartnerShopModel extends PartnerShopEntity {
  PartnerShopModel(
      {int id = 0,
      String name = '',
      String city = '',
      String photo = '',
      String need = '',
      int status = 0,
      String? messageError,
      bool? success})
      : super(
            id: id,
            name: name,
            city: city,
            photo: photo,
            need: need,
            status: status,
            messageError: messageError,
            success: success);

  factory PartnerShopModel.fromMap(Map<String, dynamic>? json) {
    if (json == null) return PartnerShopModel();

    return PartnerShopModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      city: json['city'] ?? '',
      photo: json['photo'] ?? imageDefaultSup,
      status: json['status'] ?? '',
      need: json['need'] ?? '',
    );
  }

  factory PartnerShopModel.fromJson(String source) =>
      PartnerShopModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'city': city,
      'status': status,
      'photo': photo,
      'need': need
    };
  }

  String toJson() => json.encode(toMap());
}
