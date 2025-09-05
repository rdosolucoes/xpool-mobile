import '../../../../../../shared/models/base_model.dart';

//@immutable
class ValuesHeaderEntity extends BaseModel {
  final int totalReference;
  final int totalAccept;
  final int totalReject;
  final int totalContest;
  final int refpend;
  final int refAccept;
  final int refExpired;
  final double saldo;

  ValuesHeaderEntity(
      {this.totalReference = 0,
      this.totalAccept = 0,
      this.totalReject = 0,
      this.totalContest = 0,
      this.refpend = 0,
      this.refAccept = 0,
      this.refExpired = 0,
      this.saldo = 0,
      String? messageError,
      bool? success})
      : super(messageError: messageError, success: success);

  ValuesHeaderEntity copyWith(
      {int? totalReference,
      int? totalAccept,
      int? totalReject,
      int? totalContest,
      int? refpend,
      int? refAccept,
      int? refExpired,
      double? saldo}) {
    return ValuesHeaderEntity(
      totalReference: totalReference ?? this.totalReference,
      totalAccept: totalAccept ?? this.totalAccept,
      totalReject: totalReject ?? this.totalReject,
      totalContest: totalContest ?? this.totalContest,
      refpend: refpend ?? this.refpend,
      refAccept: refAccept ?? this.refAccept,
      refExpired: refExpired ?? this.refExpired,
      saldo: saldo ?? this.saldo,
    );
  }
}
