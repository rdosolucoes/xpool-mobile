import 'package:brasil_fields/brasil_fields.dart';

import '../../../../../../shared/models/base_model.dart';

class BankAccountEntity extends BaseModel {
  final String holderName;
  final String bankCode;
  final String bankName;
  final String branchNumber;
  final String branchCheckDigit;
  final String accountNumber;
  final String accountCheckDigit;
  final String holderType;
  final String holderDocument;
  final String type;

  BankAccountEntity(
      {this.holderName = '',
      this.bankCode = '',
      this.bankName = '',
      this.branchNumber = '',
      this.branchCheckDigit = '',
      this.accountNumber = '',
      this.accountCheckDigit = '',
      this.holderType = 'individual',
      this.holderDocument = '',
      this.type = 'checking'});

  BankAccountEntity copyWith(
      {String? holderName,
      String? bankCode,
      String? bankName,
      String? branchNumber,
      String? branchCheckDigit,
      String? accountNumber,
      String? accountCheckDigit,
      String? holderType,
      String? holderDocument,
      String? type}) {
    return BankAccountEntity(
      holderName: holderName ?? this.holderName,
      bankCode: bankCode ?? this.bankCode,
      bankName: bankName ?? this.bankName,
      branchNumber: branchNumber ?? this.branchNumber,
      branchCheckDigit: branchCheckDigit ?? this.branchCheckDigit,
      accountNumber: accountNumber ?? this.accountNumber,
      accountCheckDigit: accountCheckDigit ?? this.accountCheckDigit,
      holderType: holderType ?? this.holderType,
      holderDocument: holderDocument ?? this.holderDocument,
      type: type ?? this.type,
    );
  }

  String get validation {
    if (holderName.isEmpty ||
        bankCode.isEmpty ||
        branchNumber.isEmpty ||
        accountNumber.isEmpty ||
        holderType.isEmpty ||
        holderDocument.isEmpty ||
        accountCheckDigit.isEmpty) {
      return "* Preencha todos os campos obrigatórios para continuar.";
    }

    if (holderType == "individual") {
      if (!CPFValidator.isValid(holderDocument)) {
        return "* Cpf Inválido";
      }
    } else {
      if (!CNPJValidator.isValid(holderDocument)) {
        return "* Cnpj Inválido";
      }
    }

    return "";
  }
}
