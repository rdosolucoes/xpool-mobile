import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';

abstract class ISendRememberPswEmail {
  Future<Either<Failure, bool>> call(String userName);
}
