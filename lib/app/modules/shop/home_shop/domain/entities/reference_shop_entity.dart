import '../../../../../../shared/models/base_model.dart';
import '../../../partnership_shop/domain/entities/supplier_entity.dart';

//@immutable
class ReferenceShopEntity extends BaseModel {
  final int id;
  final String dateHour;
  final String need;
  final String customerName;
  final String iconNeed;
  final String localMainText;
  final String localSecondaryText;
  final String latitude;
  final String longitude;
  final int totalReference;
  final int totalAccept;
  final int totalReject;
  final int totalContest;
  List<SupplierEntity> suppliers;
  final int status;
  final String employee;

  ReferenceShopEntity(
      {this.id = 0,
      this.dateHour = '',
      this.need = '',
      this.customerName = '',
      this.iconNeed = '',
      this.localMainText = '',
      this.localSecondaryText = '',
      this.latitude = '',
      this.longitude = '',
      this.totalReference = 0,
      this.totalAccept = 0,
      this.totalReject = 0,
      this.totalContest = 0,
      this.status = 0,
      this.suppliers = const <SupplierEntity>[],
      this.employee = "",
      String? messageError,
      bool? success})
      : super(messageError: messageError, success: success);

  ReferenceShopEntity copyWith(
      {int? id,
      String? dateHour,
      String? need,
      String? customerName,
      String? iconNeed,
      String? localMainText = '',
      String? localSecondaryText = '',
      String? latitude = '',
      String? longitude = '',
      int? totalReference,
      int? totalAccept,
      int? totalReject,
      int? totalContest,
      int? status,
      String? employee,
      List<SupplierEntity>? suppliers}) {
    return ReferenceShopEntity(
        id: id ?? this.id,
        dateHour: dateHour ?? this.dateHour,
        need: need ?? this.need,
        customerName: customerName ?? this.customerName,
        iconNeed: iconNeed ?? this.iconNeed,
        localMainText: localMainText ?? this.localMainText,
        localSecondaryText: localSecondaryText ?? this.localSecondaryText,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        totalReference: totalReference ?? this.totalReference,
        totalAccept: totalAccept ?? this.totalAccept,
        totalReject: totalReject ?? this.totalReject,
        totalContest: totalContest ?? this.totalContest,
        status: status ?? this.status,
        suppliers: suppliers ?? this.suppliers,
        employee: employee ?? this.employee);
  }
}
