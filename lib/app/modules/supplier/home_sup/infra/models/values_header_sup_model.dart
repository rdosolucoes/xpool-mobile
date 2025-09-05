import 'dart:convert';

import '../../domain/entities/values_header_sup_entity.dart';

class ValuesHeaderSupModel extends ValuesHeaderSupEntity {
  ValuesHeaderSupModel(
      {int totalReference = 0,
      int totalAccept = 0,
      int totalReject = 0,
      double refValue = 0,
      String cardDefault = "",
      String? messageError,
      bool? success})
      : super(
            totalReference: totalReference,
            totalAccept: totalAccept,
            totalReject: totalReject,
            refValue: refValue,
            cardDefault: cardDefault,
            messageError: messageError,
            success: success);

  factory ValuesHeaderSupModel.fromMap(Map<String, dynamic>? json) {
    if (json == null) return ValuesHeaderSupModel();

    return ValuesHeaderSupModel(
      totalReference: json['totalReference'] ?? '',
      totalAccept: json['totalAccept'] ?? '',
      totalReject: json['totalReject'] ?? '',
      refValue: json['refValue'] ?? '',
      cardDefault: json['cardDefault'] ?? '',
    );
  }

  factory ValuesHeaderSupModel.fromJson(String source) =>
      ValuesHeaderSupModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'totalReference': totalReference,
      'totalAccept': totalAccept,
      'totalReject': totalReject,
      'refValue': refValue,
      'cardDefault': cardDefault
    };
  }

  String toJson() => json.encode(toMap());
}
