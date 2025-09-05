//@immutable
import 'dart:convert';

import '../../domain/entities/need_sup_entity.dart';

class NeedSupModel extends NeedSupEntity {
  NeedSupModel(
      {int id = 0,
      String description = '',
      bool active = false,
      String? messageError,
      bool? success})
      : super(
            id: id,
            description: description,
            active: active,
            messageError: messageError,
            success: success);

  factory NeedSupModel.fromMap(Map<String, dynamic>? json) {
    if (json == null) return NeedSupModel();

    return NeedSupModel(
      id: json['id'] ?? '',
      description: json['description'] ?? '',
      active: json['active'] ?? '',
    );
  }

  factory NeedSupModel.fromJson(String source) =>
      NeedSupModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'active': active,
    };
  }

  String toJson() => json.encode(toMap());
}
