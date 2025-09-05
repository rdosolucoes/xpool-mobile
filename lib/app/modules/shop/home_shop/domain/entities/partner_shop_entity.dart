import '../../../../../../shared/models/base_model.dart';

//@immutable
class PartnerShopEntity extends BaseModel {
  final int id;
  final String name;
  final String city;
  final String photo;
  final String need;

  String get urlImage => 'https://empresas.ioasys.com.br/$photo';
  int status;

  PartnerShopEntity(
      {this.id = 0,
      this.name = '',
      this.city = '',
      this.status = 0,
      this.photo = '',
      this.need = '',
      String? messageError,
      bool? success})
      : super(messageError: messageError, success: success);

  PartnerShopEntity copyWith({
    int? id,
    String? name,
    String? city,
    int? status,
    String? photo,
    String? need,
  }) {
    return PartnerShopEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      city: city ?? this.city,
      status: status ?? this.status,
      photo: photo ?? this.photo,
      need: need ?? this.need,
    );
  }
}
