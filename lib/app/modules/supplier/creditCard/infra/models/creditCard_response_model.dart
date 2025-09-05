import 'dart:convert';

import '../../domain/entities/creditCard_response_entity.dart';

class CreditCardResponseModel extends CreditCardResponseEntity {
  CreditCardResponseModel(
      {String creditCardId = '',
      String lastFourDigits = '',
      String brand = '',
      bool isDefault = false})
      : super(
            creditCardId: creditCardId,
            lastFourDigits: lastFourDigits,
            brand: brand,
            isDefault: isDefault);

  factory CreditCardResponseModel.fromMap(Map<String, dynamic>? json) {
    if (json == null) return CreditCardResponseModel();

    return CreditCardResponseModel(
      creditCardId: json['creditCardId'] ?? '',
      lastFourDigits: json['lastFourDigits'] ?? '',
      brand: json['brand'] ?? '',
      isDefault: json['isDefault'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'creditCardId': creditCardId,
      'lastFourDigits': lastFourDigits,
      'brand': brand,
      'isDefault': isDefault
    };
  }

  String toJson() => json.encode(toMap());
}
