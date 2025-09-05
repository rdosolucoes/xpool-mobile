import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../infra/models/change_psw_model.dart';
import '../../entities/change_psw_entity.dart';

abstract class IChangePassword {
  Future<Either<Failure, ChangePswModel>> call(ChangePswEntity pswEntity);
}
