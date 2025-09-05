import '../../../../../../shared/models/base_model.dart';

//@immutable
class DisputeEntity extends BaseModel {
  final int id;
  final String supplierName;
  final String needDescription;
  final String customerName;
  final String imageSup;
  final String dateReference;
  final String messageContest;
  final String dateContest;

  DisputeEntity(
      {this.id = 0,
      this.supplierName = '',
      this.needDescription = '',
      this.customerName = '',
      this.imageSup = '',
      this.dateReference = '',
      this.messageContest = '',
      this.dateContest = '',
      String? messageError,
      bool? success})
      : super(messageError: messageError, success: success);

  DisputeEntity copyWith({
    int? id,
    String? supplierName,
    String? needDescription,
    String? customerName,
    String? imageSup,
    String? dateReference,
    String? messageContest,
    String? dateContest,
  }) {
    return DisputeEntity(
        id: id ?? this.id,
        supplierName: supplierName ?? this.supplierName,
        needDescription: needDescription ?? this.needDescription,
        customerName: customerName ?? this.customerName,
        imageSup: imageSup ?? this.imageSup,
        dateReference: dateReference ?? this.dateReference,
        messageContest: messageContest ?? this.messageContest,
        dateContest: dateContest ?? this.dateContest);
  }
}
