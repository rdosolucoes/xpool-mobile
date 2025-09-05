import '../../../../../../shared/models/base_model.dart';
import '../../infra/models/supplier_need_model.dart';

//@immutable
class SupplierEntity extends BaseModel {
  final int id;
  final String name;
  final String city;
  final List<SupplierNeedModel>? needs;
  final String photo;

  int status;

  SupplierEntity(
      {this.id = 0,
      this.name = '',
      this.city = '',
      this.status = 0,
      this.needs,
      this.photo = '',
      String? messageError,
      bool? success})
      : super(messageError: messageError, success: success);

  SupplierEntity copyWith({
    int? id,
    String? name,
    List<SupplierNeedModel>? needs,
    String? city,
    int? status,
    String? photo,
  }) {
    return SupplierEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      city: city ?? this.city,
      status: status ?? this.status,
      needs: needs ?? this.needs,
      photo: photo ?? this.photo,
    );
  }
}
