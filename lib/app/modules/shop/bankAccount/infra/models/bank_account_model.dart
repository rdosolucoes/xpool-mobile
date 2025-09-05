import 'dart:convert';

import '../../domain/entities/bank_account_entity.dart';

class BankAccountModel extends BankAccountEntity {
  BankAccountModel({
    String holderName = '',
    String bankCode = '',
    String bankName = '',
    String branchNumber = '',
    String branchCheckDigit = '',
    String accountNumber = '',
    String accountCheckDigit = '',
    String holderType = 'individual',
    String holderDocument = '',
    String type = 'checking',
  }) : super(
            holderName: holderName,
            bankCode: bankCode,
            bankName: bankName,
            branchNumber: branchNumber,
            branchCheckDigit: branchCheckDigit,
            accountNumber: accountNumber,
            accountCheckDigit: accountCheckDigit,
            holderType: holderType,
            holderDocument: holderDocument,
            type: type);

  factory BankAccountModel.fromMap(Map<String, dynamic>? json) {
    if (json == null) return BankAccountModel();

    return BankAccountModel(
        holderName: json['holderName'] ?? '',
        bankCode: json['bankCode'] ?? '',
        bankName: json['bankName'] ?? '',
        branchNumber: json['branchNumber'] ?? '',
        branchCheckDigit: json['branchCheckDigit'] ?? '',
        accountNumber: json['accountNumber'] ?? '',
        accountCheckDigit: json['accountCheckDigit'] ?? '',
        holderType: json['holderType'] ?? '',
        holderDocument: json['holderDocument'] ?? '',
        type: json['type'] ?? '');
  }

  Map<String, dynamic> toMap() {
    return {
      'holderName': holderName,
      'bankCode': bankCode,
      'bankName': bankName,
      'branchNumber': branchNumber,
      'branchCheckDigit': branchCheckDigit,
      'accountNumber': accountNumber,
      'accountCheckDigit': accountCheckDigit,
      'holderType': holderType,
      'holderDocument': holderDocument,
      'type': type,
    };
  }

  String toJson() => json.encode(toMap());
}
