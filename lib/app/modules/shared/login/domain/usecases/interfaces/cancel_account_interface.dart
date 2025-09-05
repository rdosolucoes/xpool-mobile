import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';

abstract class ICancelAccount {
  Future<Either<Failure, bool>> call();
}
