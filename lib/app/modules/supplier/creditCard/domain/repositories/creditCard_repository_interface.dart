import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_model.dart';
import '../../infra/models/creditCard_response_model.dart';
import '../entities/creditCard_entity.dart';

abstract class ICreditCardRepository {
  Future<Either<Failure, CreditCardEntity>> get();
  Future<Either<Failure, List<CreditCardResponseModel>>> getAll();
  Future<Either<Failure, ResultModel>> post(CreditCardEntity request);
  Future<Either<Failure, ResultModel>> setDefault(String cardId);
  Future<Either<Failure, ResultModel>> delete(String cardId);
}
