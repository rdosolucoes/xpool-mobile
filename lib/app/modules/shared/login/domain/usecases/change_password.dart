import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../infra/models/change_psw_model.dart';
import '../entities/change_psw_entity.dart';
import '../errors/errors.dart';
import '../repositories/authenticate_repository_interface.dart';
import 'interfaces/change_password_interface.dart';

class ChangePassword implements IChangePassword {
  final IAuthenticateRepository _authenticateRepository;

  ChangePassword(this._authenticateRepository);
  @override
  Future<Either<Failure, ChangePswModel>> call(
      ChangePswEntity pswEntity) async {
    if (pswEntity.validation.isNotEmpty) {
      return Left(ChangePasswordError(message: pswEntity.validation));
    }

    try {
      return _authenticateRepository.changePassword(pswEntity);
    } on Exception {
      throw FailurePostAuthenticate(message: 'Erro ao realizar login');
    }
  }
}
