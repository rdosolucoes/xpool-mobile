import 'package:flutter/foundation.dart';

import '../../../../../../shared/helpers/utils.dart';
import '../../../../../../shared/models/base_model.dart';

@immutable
class ShopEntity extends BaseModel {
  final String name;
  final String email;
  final String phone;
  final String postalCode;
  final String street;
  final String district;
  final String placeNumber;
  final String complement;
  final String state;
  final String city;
  final int cityId;
  final String errorCep;

  const ShopEntity(
      {this.name = '',
      this.email = '',
      this.phone = '',
      this.postalCode = '',
      this.state = '',
      this.city = '',
      this.cityId = 0,
      this.street = '',
      this.district = '',
      this.placeNumber = '',
      this.complement = '',
      this.errorCep = '',
      String? messageError,
      bool? success})
      : super(messageError: messageError, success: success);

  ShopEntity copyWith({
    String? name,
    String? email,
    String? phone,
    String? postalCode,
    String? state,
    String? city,
    int? cityId,
    String? street,
    String? district,
    String? placeNumber,
    String? complement,
    String? errorCep,
    String? messageError,
  }) {
    return ShopEntity(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      postalCode: postalCode ?? this.postalCode,
      street: street ?? this.street,
      placeNumber: placeNumber ?? this.placeNumber,
      district: district ?? this.district,
      complement: complement ?? this.complement,
      city: city ?? this.city,
      cityId: cityId ?? this.cityId,
      state: state ?? this.state,
      errorCep: errorCep ?? this.errorCep,
      messageError: messageError ?? this.messageError,
    );
  }

  String get validation {
    if (name.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        postalCode.isEmpty ||
        placeNumber.isEmpty ||
        city.isEmpty) {
      return "* Preencha todos os campos para continuar.";
    }

    if (!Utils.validateEmail(email)) {
      return "* Email inválido verifique.";
    }

    if (!Utils.validateEmail(email)) {
      return "Email inválido verifique.";
    }

    if (!Utils.validatePhone(phone)) {
      return "Celular inválido verifique.";
    }

    if (errorCep != "") {
      return "Informe um Cep válido";
    }

    if (name.length < 3) return "Nome muito pequeno verifique.";

    return "";
  }
}
