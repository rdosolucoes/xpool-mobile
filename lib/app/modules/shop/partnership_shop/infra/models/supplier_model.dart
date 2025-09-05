import 'dart:convert';

import '../../../../../../shared/helpers/consts.dart';
import '../../domain/entities/supplier_entity.dart';
import 'supplier_need_model.dart';

class SupplierModel extends SupplierEntity {
  SupplierModel(
      {int id = 0,
      String name = '',
      String city = '',
      String photo = '',
      List<SupplierNeedModel>? needs,
      int status = 0,
      String? messageError,
      bool? success})
      : super(
            id: id,
            name: name,
            city: city,
            photo: photo,
            needs: needs,
            status: status,
            messageError: messageError,
            success: success);

  factory SupplierModel.fromMap(Map<String, dynamic>? json) {
    if (json == null) return SupplierModel();

    var listNeeds = <SupplierNeedModel>[];

    if (json["needs"] != null) {
      listNeeds = (json["needs"] as List)
          .map((e) => SupplierNeedModel.fromMap(e))
          .toList();
    }

    return SupplierModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      city: json['city'] ?? '',
      photo: json['photo'] ?? imageDefaultSup,
      status: json['status'] ?? '',
      needs: listNeeds,
    );
  }

  factory SupplierModel.fromJson(String source) =>
      SupplierModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'city': city,
      'status': status,
      'photo': photo,
      'needs': needs
    };
  }

  String toJson() => json.encode(toMap());
}
