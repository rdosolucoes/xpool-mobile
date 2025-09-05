import '../../../../../../../shared/models/result_model.dart';
import '../../models/employee_model.dart';

abstract class IEmployeeDataSource {
  Future<List<EmployeeModel>> get();
  Future<ResultModel> save(EmployeeModel model);
  Future<ResultModel> delete(int id);
}
