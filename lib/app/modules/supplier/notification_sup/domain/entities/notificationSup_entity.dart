import '../../../../../../shared/helpers/enum.dart';
import '../../../../../../shared/models/base_model.dart';

class NotificationSupEntity extends BaseModel {
  final int? id;
  final ETypeNotification? type;
  final String? name;
  final String? message;
  final String? cityState;
  final String? dateHour;
  final String? photo;

  int status;

  NotificationSupEntity(
      {this.id,
      this.type,
      this.status = 0,
      this.name,
      this.message,
      this.cityState,
      this.dateHour,
      this.photo});

  NotificationSupEntity copyWith(
      {int? id,
      ETypeNotification? type,
      String? name,
      String? message,
      String? cityState,
      int? status,
      String? dateHour,
      String? photo}) {
    return NotificationSupEntity(
      id: id ?? this.id,
      type: type ?? this.type,
      status: status ?? this.status,
      name: name ?? this.name,
      message: message ?? this.message,
      cityState: cityState ?? this.cityState,
      dateHour: dateHour ?? this.dateHour,
      photo: photo ?? this.photo,
    );
  }
}
