import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/repository/auth_repository.dart';
import 'interfaces/validate_email_interface.dart';

class ValidateEmail implements IValidateEmail {
  final AuthRepository _authenticateRepository;

  ValidateEmail(this._authenticateRepository);
  @override
  Future<Either<Failure, bool>> call(String code) async {
    var result = await _authenticateRepository.validateEmail(code);

    return result;
  }
}
