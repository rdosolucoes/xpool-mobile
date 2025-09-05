import 'dart:convert';

import '../../domain/entities/dispute_sup_entity.dart';

class DisputeModel extends DisputeSupEntity {
  DisputeModel(
      {int referenceId = 0,
      String message = '',
      String? messageError,
      bool? success})
      : super(
            referenceId: referenceId,
            message: message,
            messageError: messageError,
            success: success);

  factory DisputeModel.fromMap(Map<String, dynamic>? json) {
    if (json == null) return DisputeModel();

    return DisputeModel(
      referenceId: json['referenceId'] ?? '',
      message: json['message'] ?? '',
    );
  }

  factory DisputeModel.fromJson(String source) =>
      DisputeModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'referenceId': referenceId,
      'message': message,
    };
  }

  String toJson() => json.encode(toMap());
}
