import 'dart:convert';

import '../../domain/entities/sup_entity.dart';

class SupModel extends SupEntity {
  SupModel(
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
      List<int>? needsId,
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
            needsId: needsId,
            messageError: messageError,
            success: success);

  factory SupModel.fromMap(Map<String, dynamic>? json) {
    if (json == null) return SupModel();

    return SupModel(
      cityId: json['cityId'] ?? 0,
      messageError: json['messageError'] ?? '',
      success: json['success'] ?? false,
    );
  }

  factory SupModel.fromJson(String source) =>
      SupModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'postalCode': postalCode,
      'phone': phone,
      'city': city,
      'cityId': cityId,
      'state': state,
      'street': street,
      'placeNumber': placeNumber,
      'district': district,
      'complement': complement,
      'needsId': needsId
    };
  }

  String toJson() => json.encode(toMap());
}
