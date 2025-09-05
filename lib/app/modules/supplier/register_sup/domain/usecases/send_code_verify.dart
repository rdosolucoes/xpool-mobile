import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../repositories/sup_repository_interface.dart';
import 'interfaces/send_code_verify.dart';

class SendCodeVerify implements ISendCodeVerify {
  final ISupRepository _supRepository;

  SendCodeVerify(this._supRepository);
  @override
  Future<Either<Failure, bool>> call(
      String email, String name, String phone) async {
    var result = await _supRepository.sendCodeVerify(email, name, phone);

    return result;
  }
}
