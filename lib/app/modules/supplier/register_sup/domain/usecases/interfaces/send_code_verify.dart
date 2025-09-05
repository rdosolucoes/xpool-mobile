import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';

abstract class ISendCodeVerify {
  Future<Either<Failure, bool>> call(String email, String name, String phone);
}
