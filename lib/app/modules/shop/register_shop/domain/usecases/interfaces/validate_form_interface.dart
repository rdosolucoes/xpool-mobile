import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../../../../../shared/models/result_model.dart';

abstract class IValidateForm {
  Future<Either<Failure, ResultModel>> call(
      String name, String email, String phone);
}
