import '../../../../../../../shared/auth/models/auth_model.dart';
import '../../models/authenticate_model.dart';
import '../../models/change_psw_model.dart';

abstract class IAuthenticateDatasource {
  Future<AuthModel> authenticate(AuthenticateModel auth);
  Future<void> unauthenticate();
  Future<bool> validateEmail(String userName, String code);
  Future<bool> sendRememberPswEmail(String userName);
  Future<String> rememberPassword(String userName);
  Future<ChangePswModel> changePassword(String userName, String newPassword);
  Future<bool> cancelAccount();
}
