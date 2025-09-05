import 'package:image_picker/image_picker.dart';

import '../../../../../../shared/helpers/consts.dart';
import '../../../../../../shared/helpers/utils.dart';
import '../../../../../../shared/models/base_model.dart';
import 'need_sup_entity.dart';

class ProfileSupEntity extends BaseModel {
  final int id;
  final String name;
  final String cpf;
  final String phone;
  final String email;
  final XFile? imageLocal;
  String image;
  final String? postalCode;
  final String? street;
  final String? district;
  final String? placeNumber;
  final String? complement;
  final String state;
  final String city;
  final int totalReference;
  final int totalAccept;
  final int totalReject;
  final List<NeedSupEntity> needs;
  List<NeedSupEntity> get listNeeds => needs.toList();
  List<int> selectedNeeds;

  ProfileSupEntity(
      {this.id = 0,
      this.name = '',
      this.cpf = '',
      this.phone = '',
      this.email = '',
      this.image = "$baseUrlStorage/images/noimage_sup.jpg",
      this.imageLocal,
      this.postalCode,
      this.street,
      this.district,
      this.placeNumber,
      this.complement,
      this.state = "",
      this.city = "",
      this.totalReference = 0,
      this.totalAccept = 0,
      this.totalReject = 0,
      required this.needs,
      required this.selectedNeeds,
      String? messageError,
      bool? success})
      : super(messageError: messageError, success: success);

  ProfileSupEntity copyWith(
      {int? id,
      String? name,
      String? cpf,
      String? phone,
      String? email,
      String? image,
      XFile? imageLocal,
      String? postalCode,
      String? street,
      String? district,
      String? placeNumber,
      String? complement,
      String? state,
      int? totalReference,
      int? totalAccept,
      int? totalReject,
      String? city,
      List<NeedSupEntity>? needs,
      List<int>? selectedNeeds,
      String? messageError}) {
    return ProfileSupEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        cpf: cpf ?? this.cpf,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        image: image ?? this.image,
        imageLocal: imageLocal ?? this.imageLocal,
        postalCode: postalCode ?? this.postalCode,
        street: street ?? this.street,
        district: district ?? this.district,
        placeNumber: placeNumber ?? this.placeNumber,
        complement: complement ?? this.complement,
        state: state ?? this.state,
        city: city ?? this.city,
        totalReference: totalReference ?? this.totalReference,
        totalAccept: totalAccept ?? this.totalAccept,
        totalReject: totalReject ?? this.totalReject,
        needs: needs ?? this.needs,
        selectedNeeds: selectedNeeds ?? this.selectedNeeds,
        messageError: messageError ?? this.messageError);
  }

  String get validation {
    if (name.isEmpty || email.isEmpty || phone.isEmpty || city == 0) {
      return "* Preencha todos os campos para continuar.";
    }

    if (!Utils.validateEmail(email)) {
      return "* Email inválido verifique.";
    }

    return "";
  }
}
