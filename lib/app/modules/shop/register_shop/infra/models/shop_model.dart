import 'dart:convert';

import '../../domain/entities/shop_entity.dart';

class ShopModel extends ShopEntity {
  const ShopModel(
      {String name = '',
      String email = '',
      String phone = '',
      String postalCode = '',
      String street = '',
      String placeNumber = '',
      String district = '',
      String complement = '',
      String city = '',
      int cityId = 0,
      String state = '',
      String? messageError,
      bool? success})
      : super(
            name: name,
            email: email,
            phone: phone,
            postalCode: postalCode,
            street: street,
            placeNumber: placeNumber,
            district: district,
            complement: complement,
            city: city,
            cityId: cityId,
            state: state,
            messageError: messageError,
            success: success);

  factory ShopModel.fromMap(Map<String, dynamic>? json) {
    if (json == null) return ShopModel();

    return ShopModel(
      cityId: json['cityId'] ?? 0,
      messageError: json['messageError'] ?? '',
      success: json['success'] ?? false,
    );
  }

  factory ShopModel.fromJson(String source) =>
      ShopModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'postalCode': postalCode,
      'city': city,
      'cityId': cityId,
      'state': state,
      'street': street,
      'placeNumber': placeNumber,
      'district': district,
      'complement': complement,
    };
  }

  String toJson() => json.encode(toMap());
}
