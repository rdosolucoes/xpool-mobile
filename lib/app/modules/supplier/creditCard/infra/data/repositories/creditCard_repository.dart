import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../../../../../shared/models/result_model.dart';
import '../../../domain/entities/creditCard_entity.dart';
import '../../../domain/repositories/creditCard_repository_interface.dart';
import '../../models/creditCard_model.dart';
import '../../models/creditCard_response_model.dart';
import '../datasources/creditCard_interface.dart';

class CreditCardRepository extends ICreditCardRepository {
  final ICreditCardDataSource _dataSource;

  CreditCardRepository(this._dataSource);

  @override
  Future<Either<Failure, CreditCardEntity>> get() async {
    try {
      var result = await _dataSource.get();

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ResultModel>> post(CreditCardEntity request) async {
    try {
      var model = CreditCardModel(
        number: request.number,
        holderName: request.holderName,
        validateDate: request.validateDate,
        cvv: request.cvv,
        brand: request.brand,
      );

      final result = await _dataSource.post(model);

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CreditCardResponseModel>>> getAll() async {
    try {
      var result = <CreditCardResponseModel>[];
      var listCards = await _dataSource.getAll();

      result = listCards
          .map((e) => CreditCardResponseModel(
              creditCardId: e.creditCardId,
              lastFourDigits: e.lastFourDigits,
              brand: e.brand,
              isDefault: e.isDefault))
          .toList();

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ResultModel>> delete(String cardId) async {
    try {
      final result = await _dataSource.delete(cardId);

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ResultModel>> setDefault(String cardId) async {
    try {
      final result = await _dataSource.setDefault(cardId);

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }
}
