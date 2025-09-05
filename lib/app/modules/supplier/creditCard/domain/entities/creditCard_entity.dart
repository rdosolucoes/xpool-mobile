import 'package:encrypt/encrypt.dart';

import '../../../../../../shared/models/base_model.dart';

class CreditCardEntity extends BaseModel {
  final Encrypted? number;
  final Encrypted? holderName;
  final Encrypted? validateDate;
  final Encrypted? cvv;
  final String brand;

  CreditCardEntity(
      {this.number,
      this.holderName,
      this.validateDate,
      this.cvv,
      this.brand = ''});

  CreditCardEntity copyWith({
    Encrypted? number,
    Encrypted? holderName,
    Encrypted? validateDate,
    Encrypted? cvv,
    String? brand,
  }) {
    return CreditCardEntity(
        number: number ?? this.number,
        holderName: holderName ?? this.holderName,
        validateDate: validateDate ?? this.validateDate,
        cvv: cvv ?? this.cvv,
        brand: brand ?? this.brand);
  }

  String get validation {
    if (number == null ||
        holderName == null ||
        validateDate == null ||
        cvv == null) {
      return "* Preencha todos os campos obrigatórios para continuar.";
    }

    return "";
  }
}
