import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';

abstract class IUnauthenticateRepository {
  Future<Either<Failure, bool>> logOut();
  Future<Either<Failure, bool>> cancelAccount();
}
