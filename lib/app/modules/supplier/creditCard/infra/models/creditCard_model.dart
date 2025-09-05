import 'dart:convert';

import 'package:encrypt/encrypt.dart';

import '../../domain/entities/creditCard_entity.dart';

class CreditCardModel extends CreditCardEntity {
  CreditCardModel(
      {Encrypted? number,
      Encrypted? holderName,
      Encrypted? validateDate,
      Encrypted? cvv,
      String brand = ''})
      : super(
            number: number,
            holderName: holderName,
            validateDate: validateDate,
            cvv: cvv,
            brand: brand);

  factory CreditCardModel.fromMap(Map<String, dynamic>? json) {
    if (json == null) return CreditCardModel();

    return CreditCardModel(
      number: json['number'] ?? '',
      holderName: json['holderName'] ?? '',
      validateDate: json['validateDate'] ?? '',
      cvv: json['cvv'] ?? '',
      brand: json['brand'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'holderName': holderName,
      'validateDate': validateDate,
      'cvv': cvv,
      'brand': brand
    };
  }

  String toJson() => json.encode(toMap());
}
