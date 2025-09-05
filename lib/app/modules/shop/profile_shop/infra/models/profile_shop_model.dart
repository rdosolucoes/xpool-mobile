//@immutable
import 'dart:convert';

import '../../../../../../shared/helpers/consts.dart';
import '../../domain/entities/profile_shop_entity.dart';

class ProfileShopModel extends ProfileShopEntity {
  ProfileShopModel(
      {int id = 0,
      String name = '',
      String cpf = '',
      String phone = '',
      String email = '',
      String image = "",
      String? postalCode,
      String? street,
      String? placeNumber,
      String? complement,
      String state = "",
      String city = "",
      int totalReference = 0,
      int totalAccept = 0,
      int totalReject = 0,
      String? messageError,
      bool? success})
      : super(
            id: id,
            name: name,
            cpf: cpf,
            phone: phone,
            email: email,
            image: image,
            postalCode: postalCode,
            street: street,
            placeNumber: placeNumber,
            complement: complement,
            state: state,
            city: city,
            totalReference: totalReference,
            totalAccept: totalAccept,
            totalReject: totalReject,
            messageError: messageError,
            success: success);

  factory ProfileShopModel.fromMap(Map<String, dynamic>? json) {
    if (json == null) return ProfileShopModel();

    var image = "$baseUrlStorage/images/noimage_shop.png";

    if (json['image'] != null && json['image'] != "") image = json['image'];

    return ProfileShopModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      cpf: json['cpf'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      image: image,
      postalCode: json['postalCode'] ?? '',
      street: json['street'] ?? '',
      placeNumber: json['placeNumber'] ?? '',
      complement: json['complement'] ?? '',
      state: json['state'] ?? '',
      city: json['city'] ?? '',
      totalReference: json['totalReference'] ?? '',
      totalAccept: json['totalAccept'] ?? '',
      totalReject: json['totalReject'] ?? '',
    );
  }

  factory ProfileShopModel.fromMapPost(Map<String, dynamic>? json) {
    if (json == null) return ProfileShopModel();

    return ProfileShopModel(
      messageError: json['messageError'] ?? '',
      success: json['success'] ?? false,
    );
  }

  factory ProfileShopModel.fromJson(String source) =>
      ProfileShopModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'cpf': cpf,
      'phone': phone,
      'email': email,
      'image': image,
      'postalCode': postalCode,
      'street': street,
      'placeNumber': placeNumber,
      'complement': complement,
      'state': state,
      'city': city,
      'totalReference': totalReference,
      'totalAccept': totalAccept,
      'totalReject': totalReject
    };
  }

  String toJson() => json.encode(toMap());
}
