import 'dart:convert';

import 'creditCard_token_model.dart';

class TokenModel {
  String? token;
  String? type;
  CreditCardTokenModel? card;

  TokenModel({
    this.token,
    this.type,
    this.card,
  });

  factory TokenModel.fromMap(Map<String, dynamic>? json) {
    if (json == null) return TokenModel();

    return TokenModel(
      token: json['id'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'type': type, 'card': card!.toMap()};
  }

  String toJson() => json.encode(toMap());
}
