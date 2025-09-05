import 'dart:convert';

class DropdownModel {
  final int id;
  final String name;
  DropdownModel({this.id = 0, this.name = ''});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory DropdownModel.fromMap(Map<String, dynamic> map) {
    return DropdownModel(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DropdownModel.fromJson(String source) =>
      DropdownModel.fromMap(json.decode(source));
}
