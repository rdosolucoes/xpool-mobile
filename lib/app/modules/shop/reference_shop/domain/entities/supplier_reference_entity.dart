import '../../../../../../shared/models/base_model.dart';

//@immutable
class SupplierReferenceEntity extends BaseModel {
  final int id;
  final String name;
  final String city;
  final String photo;
  final String recipientId;
  final int totalReference;
  final int totalAccept;
  final int totalReject;

  bool checked;

  String get urlImage => 'https://empresas.ioasys.com.br/$photo';
  int status;

  SupplierReferenceEntity(
      {this.id = 0,
      this.name = '',
      this.city = '',
      this.status = 0,
      this.photo = '',
      this.checked = false,
      this.totalReference = 0,
      this.totalAccept = 0,
      this.totalReject = 0,
      this.recipientId = "",
      String? messageError,
      bool? success})
      : super(messageError: messageError, success: success);

  SupplierReferenceEntity copyWith(
      {int? id,
      String? name,
      String? city,
      int? status,
      String? photo,
      bool? checked,
      int? totalReference,
      int? totalAccept,
      int? totalReject,
      String? recipientId}) {
    return SupplierReferenceEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        city: city ?? this.city,
        status: status ?? this.status,
        photo: photo ?? this.photo,
        checked: checked ?? this.checked,
        totalReference: totalReference ?? this.totalReference,
        totalAccept: totalAccept ?? this.totalAccept,
        totalReject: totalReject ?? this.totalReject,
        recipientId: recipientId ?? this.recipientId);
  }
}
