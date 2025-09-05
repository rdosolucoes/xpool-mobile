import 'dart:convert';

class LocalizationModel {
  final int id;
  final String description;
  final String mainText;
  final String secondaryText;
  final String latitude;
  final String longitude;
  LocalizationModel(
      {this.id = 0,
      this.description = '',
      this.mainText = '',
      this.secondaryText = '',
      this.latitude = '',
      this.longitude = ''});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'mainText': mainText,
      'secondaryText': secondaryText,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory LocalizationModel.fromMap(Map<String, dynamic> map) {
    return LocalizationModel(
      id: map['id'],
      description: map['description'],
      mainText: map['mainText'],
      secondaryText: map['secondaryText'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LocalizationModel.fromJson(String source) =>
      LocalizationModel.fromMap(json.decode(source));
}
