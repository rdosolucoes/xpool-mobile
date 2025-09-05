import '../../../../../../shared/helpers/consts.dart';
import '../../../../../../shared/models/base_model.dart';

//@immutable
class ReferenceSupEntity extends BaseModel {
  final int id;
  final String userOrig;
  final String urlLogo;
  final String dateHour;
  final String need;
  final String iconNeed;
  final String localMainText;
  final String localSecondaryText;
  final String latitude;
  final String longitude;
  final int totalReference;
  final int totalAccept;
  final int totalReject;
  final int status;
  final String description;

  ReferenceSupEntity(
      {this.id = 0,
      this.userOrig = '',
      this.urlLogo = imageDefault,
      this.dateHour = '',
      this.need = '',
      this.iconNeed = '',
      this.localMainText = '',
      this.localSecondaryText = '',
      this.latitude = '',
      this.longitude = '',
      this.totalReference = 0,
      this.totalAccept = 0,
      this.totalReject = 0,
      this.status = 0,
      this.description = '',
      String? messageError,
      bool? success})
      : super(messageError: messageError, success: success);

  ReferenceSupEntity copyWith(
      {int? id,
      String? userOrig,
      String? urlLogo,
      String? dateHour,
      String? need,
      String? iconNeed,
      String? localMainText = '',
      String? localSecondaryText = '',
      String? latitude = '',
      String? longitude = '',
      int? totalReference,
      int? totalAccept,
      int? totalReject,
      int? status,
      String? description}) {
    return ReferenceSupEntity(
      id: id ?? this.id,
      userOrig: userOrig ?? this.userOrig,
      urlLogo: urlLogo ?? this.urlLogo,
      dateHour: dateHour ?? this.dateHour,
      need: need ?? this.need,
      iconNeed: iconNeed ?? this.iconNeed,
      localMainText: localMainText ?? this.localMainText,
      localSecondaryText: localSecondaryText ?? this.localSecondaryText,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      totalReference: totalReference ?? this.totalReference,
      totalAccept: totalAccept ?? this.totalAccept,
      totalReject: totalReject ?? this.totalReject,
      status: status ?? this.status,
      description: description ?? this.description,
    );
  }
}
