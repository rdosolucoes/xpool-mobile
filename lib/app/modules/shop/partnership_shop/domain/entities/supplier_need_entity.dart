import 'package:flutter/foundation.dart';

@immutable
class SupplierNeedEntity {
  final int id;
  final String description;
  final String image;

  const SupplierNeedEntity(
      {this.id = 0, this.description = '', this.image = ''});

  SupplierNeedEntity copyWith({int? id, String? description, String? image}) {
    return SupplierNeedEntity(
      id: id ?? this.id,
      description: description ?? this.description,
      image: image ?? this.image,
    );
  }
}
