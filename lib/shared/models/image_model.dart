import 'dart:convert';

import 'package:dio/dio.dart';

class ImageModel {
  final int id;
  final MultipartFile? image;
  ImageModel({this.id = 0, this.image});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
    };
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      id: map['id'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageModel.fromJson(String source) =>
      ImageModel.fromMap(json.decode(source));
}
