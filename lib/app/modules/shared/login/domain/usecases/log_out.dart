import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../repositories/unauthenticate_repository_interface.dart';
import 'interfaces/log_out_interface.dart';

class LogOut implements ILogOut {
  final IUnauthenticateRepository _unauthenticateRepository;

  LogOut(this._unauthenticateRepository);
  @override
  Future<Either<Failure, bool>> call() async {
    var result = await _unauthenticateRepository.logOut();

    return result;
  }
}
