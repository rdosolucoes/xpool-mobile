import '../../../../../../shared/models/base_model.dart';
import '../../../../../../shared/models/localization_model.dart';

//@immutable
class ReferenceEntity extends BaseModel {
  final List<int>? supIds;
  final String name;
  final LocalizationModel? localization;
  final String phone;
  final String description;
  final int needId;

  ReferenceEntity(
      {this.supIds,
      this.name = '',
      this.localization,
      this.phone = '',
      this.description = '',
      this.needId = 0,
      String? messageError,
      bool? success})
      : super(messageError: messageError, success: success);

  ReferenceEntity copyWith(
      {List<int>? supIds,
      String? name,
      LocalizationModel? localization,
      String? phone,
      String? description,
      int? needId}) {
    return ReferenceEntity(
        supIds: supIds ?? this.supIds,
        name: name ?? this.name,
        localization: localization ?? this.localization,
        phone: phone ?? this.phone,
        description: description ?? this.description,
        needId: needId ?? this.needId);
  }
}
