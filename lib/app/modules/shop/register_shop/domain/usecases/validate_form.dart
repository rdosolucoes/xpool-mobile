import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_model.dart';
import '../../../../../../shared/repository/auth_repository.dart';
import 'interfaces/validate_form_interface.dart';

class ValidateForm implements IValidateForm {
  final AuthRepository _authenticateRepository;

  ValidateForm(this._authenticateRepository);
  @override
  Future<Either<Failure, ResultModel>> call(
      String name, String email, String phone) async {
    var result = await _authenticateRepository.validateForm(name, email, phone);

    return result;
  }
}
