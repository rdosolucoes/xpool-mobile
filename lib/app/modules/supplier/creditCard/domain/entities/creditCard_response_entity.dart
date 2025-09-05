import '../../../../../../shared/models/base_model.dart';

class CreditCardResponseEntity extends BaseModel {
  final String creditCardId;
  final String lastFourDigits;
  final String brand;
  final bool isDefault;

  CreditCardResponseEntity(
      {this.creditCardId = '',
      this.lastFourDigits = '',
      this.brand = '',
      this.isDefault = false});

  CreditCardResponseEntity copyWith({
    String? creditCardId,
    String? lastFourDigits,
    String? brand,
    bool? isDefault,
  }) {
    return CreditCardResponseEntity(
        creditCardId: creditCardId ?? this.creditCardId,
        lastFourDigits: lastFourDigits ?? this.lastFourDigits,
        brand: brand ?? this.brand,
        isDefault: isDefault ?? this.isDefault);
  }
}
