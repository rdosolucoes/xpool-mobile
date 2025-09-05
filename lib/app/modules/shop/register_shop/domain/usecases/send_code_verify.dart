import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/repository/auth_repository.dart';
import 'interfaces/send_code_verify_interface.dart';

class SendCodeVerify implements ISendCodeVerify {
  final AuthRepository _authRepository;

  SendCodeVerify(this._authRepository);
  @override
  Future<Either<Failure, bool>> call(
      String email, String name, String phone) async {
    var result = await _authRepository.sendCodeVerify(email, name, phone);

    return result;
  }
}
