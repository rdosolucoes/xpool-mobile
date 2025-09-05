import '../../../../../../shared/models/base_model.dart';

//@immutable
class DisputeSupEntity extends BaseModel {
  final int referenceId;
  final String message;

  DisputeSupEntity(
      {this.referenceId = 0,
      this.message = '',
      String? messageError,
      bool? success})
      : super(messageError: messageError, success: success);

  DisputeSupEntity copyWith({
    int? referenceId,
    String? message,
  }) {
    return DisputeSupEntity(
      referenceId: referenceId ?? this.referenceId,
      message: message ?? this.message,
    );
  }
}
