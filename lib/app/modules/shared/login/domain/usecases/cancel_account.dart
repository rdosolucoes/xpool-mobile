import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../repositories/unauthenticate_repository_interface.dart';
import 'interfaces/cancel_account_interface.dart';

class CancelAccount implements ICancelAccount {
  final IUnauthenticateRepository _unauthenticateRepository;

  CancelAccount(this._unauthenticateRepository);
  @override
  Future<Either<Failure, bool>> call() async {
    var result = await _unauthenticateRepository.cancelAccount();

    return result;
  }
}
