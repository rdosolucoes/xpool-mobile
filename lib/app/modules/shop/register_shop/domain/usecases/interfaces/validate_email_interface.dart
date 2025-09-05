import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';

abstract class IValidateEmail {
  Future<Either<Failure, bool>> call(String code);
}
