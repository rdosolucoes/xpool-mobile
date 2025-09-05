import '../../domain/entities/authenticate_entity.dart';

class AuthenticateModel extends AuthenticateEntity {
  AuthenticateModel(
      {required String login,
      required String password,
      bool? isSignUp,
      String? playerId,
      bool? emailValidate,
      bool? isEmployee})
      : super(
            login: login,
            password: password,
            isSignUp: isSignUp!,
            playerId: playerId,
            emailValidate: emailValidate!,
            isEmployee: isEmployee!);
}
