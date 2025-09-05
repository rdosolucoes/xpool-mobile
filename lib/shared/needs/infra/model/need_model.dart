import 'dart:convert';

import '../../domain/entity/need_entity.dart';

class NeedModel extends NeedEntity {
  NeedModel({int id = 0, String description = '', String image = ''})
      : super(
          id: id,
          description: description,
          image: image,
        );

  factory NeedModel.fromMap(Map<String, dynamic>? json) {
    if (json == null) return NeedModel();

    return NeedModel(
      id: json['id'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
    );
  }

  factory NeedModel.fromJson(String source) =>
      NeedModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {'id': id, 'description': description, 'image': image};
  }

  String toJson() => json.encode(toMap());
}
