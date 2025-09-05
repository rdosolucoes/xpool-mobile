import 'dart:convert';

import '../../domain/entities/dispute_entity.dart';

class DisputeModel extends DisputeEntity {
  DisputeModel(
      {int id = 0,
      String supplierName = "",
      String needDescription = "",
      String customerName = "",
      String imageSup = "",
      String dateReference = "",
      String messageContest = "",
      String dateContest = "",
      String? messageError,
      bool? success})
      : super(
            id: id,
            supplierName: supplierName,
            needDescription: needDescription,
            customerName: customerName,
            imageSup: imageSup,
            dateReference: dateReference,
            messageContest: messageContest,
            dateContest: dateContest,
            messageError: messageError,
            success: success);

  factory DisputeModel.fromMap(Map<String, dynamic>? json) {
    if (json == null) return DisputeModel();

    return DisputeModel(
      id: json['id'] ?? 0,
      supplierName: json['supplierName'] ?? '',
      needDescription: json['needDescription'] ?? '',
      customerName: json['customerName'] ?? '',
      imageSup: json['imageSup'] ?? '',
      dateReference: json['dateReference'] ?? '',
      messageContest: json['messageContest'] ?? '',
      dateContest: json['dateContest'] ?? '',
    );
  }

  factory DisputeModel.fromJson(String source) =>
      DisputeModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'supplierName': supplierName,
      'needDescription': needDescription,
      'customerName': customerName,
      'imageSup': imageSup,
      'dateReference': dateReference,
      'messageContest': messageContest,
      'dateContest': dateContest,
    };
  }

  String toJson() => json.encode(toMap());
}
