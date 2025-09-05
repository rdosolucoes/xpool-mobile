import 'package:dartz/dartz.dart';

import '../../../../../../shared/auth/models/auth_model.dart';
import '../../../../../../shared/helpers/errors.dart';
import '../entities/authenticate_entity.dart';
import '../errors/errors.dart';
import '../repositories/authenticate_repository_interface.dart';
import 'interfaces/post_authenticate_by_login_interface.dart';

class PostAuthenticateByLogin implements IPostAuthenticateByLogin {
  final IAuthenticateRepository _authenticateRepository;

  PostAuthenticateByLogin(this._authenticateRepository);
  @override
  Future<Either<Failure, AuthModel>> call(AuthenticateEntity request) async {
    if (request.validation.isNotEmpty) {
      return Left(FailurePostAuthenticate(message: request.validation));
    }

    try {
      return _authenticateRepository.authenticate(request);
    } on Exception {
      throw FailurePostAuthenticate(message: 'Erro ao realizar login');
    }
  }
}
