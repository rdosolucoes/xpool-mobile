import '../../../../../../shared/models/base_model.dart';

//@immutable
class PartnerSupEntity extends BaseModel {
  final int id;
  final String name;
  final String city;
  final String photo;

  String get urlImage => 'https://empresas.ioasys.com.br/$photo';
  int status;

  PartnerSupEntity(
      {this.id = 0,
      this.name = '',
      this.city = '',
      this.status = 0,
      this.photo = '',
      String? messageError,
      bool? success})
      : super(messageError: messageError, success: success);

  PartnerSupEntity copyWith({
    int? id,
    String? name,
    String? city,
    int? status,
    String? photo,
  }) {
    return PartnerSupEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      city: city ?? this.city,
      status: status ?? this.status,
      photo: photo ?? this.photo,
    );
  }
}
