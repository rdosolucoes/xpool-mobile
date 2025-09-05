import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../repositories/authenticate_repository_interface.dart';
import 'interfaces/validate_email_interface.dart';

class ValidateEmail implements IValidateEmail {
  final IAuthenticateRepository _authenticateRepository;

  ValidateEmail(this._authenticateRepository);
  @override
  Future<Either<Failure, bool>> call(String userName, String code) async {
    var result = await _authenticateRepository.validateEmail(userName, code);

    return result;
  }
}
