import 'dart:convert';

import '../../domain/entities/supplier_need_entity.dart';

class SupplierNeedModel extends SupplierNeedEntity {
  SupplierNeedModel({int id = 0, String description = '', String image = ''})
      : super(id: id, description: description, image: image);

  factory SupplierNeedModel.fromMap(Map<String, dynamic>? json) {
    if (json == null) return SupplierNeedModel();

    return SupplierNeedModel(
      id: json['id'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
    );
  }

  factory SupplierNeedModel.fromJson(String source) =>
      SupplierNeedModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {'id': id, 'description': description, 'image': image};
  }

  String toJson() => json.encode(toMap());
}
