import '../../../../../../../shared/models/result_model.dart';
import '../../models/creditCard_model.dart';
import '../../models/creditCard_response_model.dart';
import '../../models/token_model.dart';

abstract class ICreditCardDataSource {
  Future<CreditCardModel> get();
  Future<ResultModel> post(CreditCardModel model);
  Future<ResultModel> delete(String cardId);
  Future<ResultModel> setDefault(String cardId);
  Future<List<CreditCardResponseModel>> getAll();
  Future<String> createToken(TokenModel model);
}
