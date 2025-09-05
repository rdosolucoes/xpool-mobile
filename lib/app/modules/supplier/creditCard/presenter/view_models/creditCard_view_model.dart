import '../../domain/entities/creditCard_entity.dart';
import '../../infra/models/creditCard_response_model.dart';

class CreditCardVM {
  final List<CreditCardResponseModel> creditCards;
  final CreditCardEntity? creditCard;
  final String filter;
  final int status;

  List<String> filterneeds;

  CreditCardVM(
      {this.creditCards = const <CreditCardResponseModel>[],
      this.filter = '',
      this.status = 0,
      this.filterneeds = const <String>[],
      this.creditCard});

  CreditCardVM copyWith(
      {List<CreditCardResponseModel>? creditCards,
      String? filter,
      int? status,
      List<String>? filterneeds,
      CreditCardEntity? creditCard}) {
    return CreditCardVM(
      creditCards: creditCards ?? this.creditCards,
      filter: filter ?? this.filter,
      status: status ?? this.status,
      filterneeds: filterneeds ?? this.filterneeds,
      creditCard: creditCard ?? this.creditCard,
    );
  }
}
