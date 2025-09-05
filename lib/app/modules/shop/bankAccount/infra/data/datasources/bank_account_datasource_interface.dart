import '../../../../../../../shared/models/result_model.dart';
import '../../models/bank_account_model.dart';

abstract class IBankAccountDataSource {
  Future<BankAccountModel> get();
  Future<ResultModel> post(BankAccountModel model);
}
