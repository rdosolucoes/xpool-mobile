import 'package:dartz/dartz.dart';

import '../../../../../../shared/auth/models/auth_model.dart';
import '../../../../../../shared/helpers/errors.dart';
import '../../infra/models/change_psw_model.dart';
import '../entities/authenticate_entity.dart';
import '../entities/change_psw_entity.dart';

abstract class IAuthenticateRepository {
  Future<Either<Failure, AuthModel>> authenticate(AuthenticateEntity resquest);
  Future<Either<Failure, bool>> validateEmail(String userName, String code);
  Future<Either<Failure, bool>> sendRememberPswEmail(String userName);
  Future<Either<Failure, String>> rememberPassword(String userName);
  Future<Either<Failure, ChangePswModel>> changePassword(
      ChangePswEntity pswEntity);
}
