import 'dart:convert';

import '../../../../../../shared/helpers/consts.dart';
import '../../domain/entities/shop_entity.dart';

class ShopModel extends ShopEntity {
  ShopModel(
      {int id = 0,
      String name = '',
      String city = '',
      int status = 0,
      String photo = '',
      String? messageError,
      bool? success})
      : super(
            id: id,
            name: name,
            city: city,
            status: status,
            photo: photo,
            messageError: messageError,
            success: success);

  factory ShopModel.fromMap(Map<String, dynamic>? json) {
    if (json == null) return ShopModel();

    return ShopModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      city: json['city'] ?? '',
      status: json['status'] ?? '',
      photo: json['photo'] ?? imageDefault,
    );
  }

  factory ShopModel.fromJson(String source) =>
      ShopModel.fromMap(json.decode(source));

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
