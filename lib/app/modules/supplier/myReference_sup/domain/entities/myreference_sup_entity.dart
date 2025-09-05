import '../../../../../../shared/models/base_model.dart';

//@immutable
class MyReferenceSupEntity extends BaseModel {
  final int id;
  final String shopLogo;
  final String shopName;
  final String customerName;
  final String customerPhone;
  final String dateHour;
  final String needDescription;
  final String iconNeed;
  final String taskDescription;
  final String localMainText;
  final String localSecondaryText;
  final String latitude;
  final String longitude;
  final int status;
  final int doneDeal;
  final String reply;

  MyReferenceSupEntity(
      {this.id = 0,
      this.shopLogo = '',
      this.shopName = '',
      this.customerName = '',
      this.customerPhone = '',
      this.dateHour = '',
      this.needDescription = '',
      this.iconNeed = '',
      this.taskDescription = '',
      this.localMainText = '',
      this.localSecondaryText = '',
      this.latitude = '',
      this.longitude = '',
      this.status = 0,
      this.reply = '',
      this.doneDeal = 0,
      String? messageError,
      bool? success})
      : super(messageError: messageError, success: success);

  MyReferenceSupEntity copyWith(
      {int? id,
      String? shopLogo,
      String? shopName,
      String? customerName,
      String? dateHour,
      String? needDescription,
      String? iconNeed,
      String? taskDescription,
      String? localMainText,
      String? localSecondaryText,
      String? latitude,
      String? longitude = '',
      int? status,
      String? reply,
      int? doneDeal}) {
    return MyReferenceSupEntity(
        id: id ?? this.id,
        shopLogo: shopLogo ?? this.shopLogo,
        shopName: shopName ?? this.shopName,
        customerName: customerName ?? this.customerName,
        dateHour: dateHour ?? this.dateHour,
        needDescription: needDescription ?? this.needDescription,
        iconNeed: iconNeed ?? this.iconNeed,
        localMainText: localMainText ?? this.localMainText,
        localSecondaryText: localSecondaryText ?? this.localSecondaryText,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        taskDescription: taskDescription ?? this.taskDescription,
        status: status ?? this.status,
        reply: reply ?? this.reply,
        doneDeal: doneDeal ?? this.doneDeal);
  }
}
