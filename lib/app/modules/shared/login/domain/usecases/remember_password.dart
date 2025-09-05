import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../repositories/authenticate_repository_interface.dart';
import 'interfaces/remember_password_interface.dart';

class RememberPassword implements IRememberPassword {
  final IAuthenticateRepository _authenticateRepository;

  RememberPassword(this._authenticateRepository);
  @override
  Future<Either<Failure, String>> call(String userName) async {
    var result = await _authenticateRepository.rememberPassword(userName);

    return result;
  }
}
