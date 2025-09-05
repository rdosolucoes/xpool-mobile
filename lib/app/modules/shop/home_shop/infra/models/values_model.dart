import 'dart:convert';

import '../../domain/entities/values_header_entity.dart';

class ValuesModel extends ValuesHeaderEntity {
  ValuesModel(
      {int totalReference = 0,
      int totalAccept = 0,
      int totalReject = 0,
      int totalContest = 0,
      int refpend = 0,
      int refAccept = 0,
      int refExpired = 0,
      double saldo = 0,
      String? messageError,
      bool? success})
      : super(
            totalReference: totalReference,
            totalAccept: totalAccept,
            totalReject: totalReject,
            totalContest: totalContest,
            refpend: refpend,
            refAccept: refAccept,
            refExpired: refExpired,
            saldo: saldo,
            messageError: messageError,
            success: success);

  factory ValuesModel.fromMap(Map<String, dynamic>? json) {
    if (json == null) return ValuesModel();

    return ValuesModel(
      totalReference: json['totalReference'] ?? '',
      totalAccept: json['totalAccept'] ?? '',
      totalReject: json['totalReject'] ?? '',
      totalContest: json['totalContest'] ?? '',
      refpend: json['refPend'] ?? '',
      refAccept: json['refAccept'] ?? '',
      refExpired: json['refExpired'] ?? '',
      saldo: json['saldo'] + .00 ?? '',
    );
  }

  factory ValuesModel.fromJson(String source) =>
      ValuesModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'totalReference': totalReference,
      'totalAccept': totalAccept,
      'totalReject': totalReject,
      'totalContest': totalContest,
      'refpend': refpend,
      'refAccept': refAccept,
      'refExpired': refExpired,
      'saldo': saldo
    };
  }

  String toJson() => json.encode(toMap());
}
