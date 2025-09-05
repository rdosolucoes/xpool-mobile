import 'dart:convert';

class CreditCardTokenModel {
  String number;
  String holderName;
  String expMonth;
  String expYear;
  String cvv;
  String label;

  CreditCardTokenModel(
      {this.number = '',
      this.holderName = '',
      this.expMonth = '',
      this.expYear = '',
      this.cvv = '',
      this.label = ''});

  factory CreditCardTokenModel.fromMap(Map<String, dynamic>? json) {
    if (json == null) return CreditCardTokenModel();

    return CreditCardTokenModel(
      number: json['number'] ?? '',
      holderName: json['holder_name'] ?? '',
      expMonth: json['exp_month'] ?? '',
      expYear: json['exp_year'] ?? '',
      cvv: json['cvv'] ?? '',
      label: json['label'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'holder_name': holderName,
      'exp_month': expMonth,
      'exp_year': expYear,
      'cvv': cvv,
      'label': label
    };
  }

  String toJson() => json.encode(toMap());
}
