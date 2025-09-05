import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';

abstract class IRememberPassword {
  Future<Either<Failure, String>> call(String userName);
}
