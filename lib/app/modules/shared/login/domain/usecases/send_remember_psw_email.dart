import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../repositories/authenticate_repository_interface.dart';
import 'interfaces/send_remember_psw_email_interface.dart';

class SendRememberPswEmail implements ISendRememberPswEmail {
  final IAuthenticateRepository _authenticateRepository;

  SendRememberPswEmail(this._authenticateRepository);
  @override
  Future<Either<Failure, bool>> call(String userName) async {
    var result = await _authenticateRepository.sendRememberPswEmail(userName);

    return result;
  }
}
