//@immutable
import 'dart:convert';

import '../../../../../../shared/helpers/consts.dart';
import '../../domain/entities/need_sup_entity.dart';
import '../../domain/entities/profile_sup_entity.dart';

class ProfileSupModel extends ProfileSupEntity {
  ProfileSupModel(
      {int id = 0,
      String name = '',
      String cpf = '',
      String phone = '',
      String email = '',
      String image = "",
      String? postalCode,
      String? street,
      String? district,
      String? placeNumber,
      String? complement,
      String state = "",
      String city = "",
      int totalReference = 0,
      int totalAccept = 0,
      int totalReject = 0,
      List<int> selectedNeeds = const <int>[],
      List<NeedSupEntity> needs = const <NeedSupEntity>[],
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
            district: district,
            placeNumber: placeNumber,
            complement: complement,
            state: state,
            city: city,
            totalReference: totalReference,
            totalAccept: totalAccept,
            totalReject: totalReject,
            needs: needs,
            selectedNeeds: selectedNeeds,
            messageError: messageError,
            success: success);

  factory ProfileSupModel.fromMap(Map<String, dynamic>? json) {
    if (json == null) return ProfileSupModel();

    var image = "$baseUrlStorage/images/noimage_sup.jpg";

    if (json['image'] != null && json['image'] != "") image = json['image'];

    return ProfileSupModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      cpf: json['cpf'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      image: image,
      postalCode: json['postalCode'] ?? '',
      street: json['street'] ?? '',
      district: json['district'] ?? '',
      placeNumber: json['placeNumber'] ?? '',
      complement: json['complement'] ?? '',
      state: json['state'] ?? '',
      city: json['city'] ?? '',
      totalReference: json['totalReference'] ?? '',
      totalAccept: json['totalAccept'] ?? '',
      totalReject: json['totalReject'] ?? '',
    );
  }

  factory ProfileSupModel.fromMapPost(Map<String, dynamic>? json) {
    if (json == null) return ProfileSupModel();

    return ProfileSupModel(
      messageError: json['messageError'] ?? '',
      success: json['success'] ?? false,
    );
  }

  factory ProfileSupModel.fromJson(String source) =>
      ProfileSupModel.fromMap(json.decode(source));

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
      'district': district,
      'placeNumber': placeNumber,
      'complement': complement,
      'state': state,
      'city': city,
      'totalReference': totalReference,
      'totalAccept': totalAccept,
      'totalReject': totalReject,
      'selectedNeeds': selectedNeeds
    };
  }

  String toJson() => json.encode(toMap());
}
