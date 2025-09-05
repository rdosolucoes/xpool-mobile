import '../../../../../../shared/models/base_model.dart';

//@immutable
class ValuesHeaderSupEntity extends BaseModel {
  final int totalReference;
  final int totalAccept;
  final int totalReject;
  final double refValue;
  final String cardDefault;

  ValuesHeaderSupEntity(
      {this.totalReference = 0,
      this.totalAccept = 0,
      this.totalReject = 0,
      this.refValue = 0,
      this.cardDefault = "",
      String? messageError,
      bool? success})
      : super(messageError: messageError, success: success);

  ValuesHeaderSupEntity copyWith(
      {int? totalReference,
      int? totalAccept,
      int? totalReject,
      double? refValue,
      String? cardDefault}) {
    return ValuesHeaderSupEntity(
        totalReference: totalReference ?? this.totalReference,
        totalAccept: totalAccept ?? this.totalAccept,
        totalReject: totalReject ?? this.totalReject,
        refValue: refValue ?? this.refValue,
        cardDefault: cardDefault ?? this.cardDefault);
  }
}
