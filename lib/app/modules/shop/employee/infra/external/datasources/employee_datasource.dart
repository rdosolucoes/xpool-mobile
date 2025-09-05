import 'package:dio/native_imp.dart';

import '../../../../../../../shared/helpers/api.dart';
import '../../../../../../../shared/helpers/errors.dart';
import '../../../../../../../shared/models/result_model.dart';
import '../../data/datasources/employee_datasource_interface.dart';
import '../../models/employee_model.dart';

class EmployeeDataSource implements IEmployeeDataSource {
  final DioForNative _client;

  EmployeeDataSource(this._client);

  @override
  Future<List<EmployeeModel>> get() async {
    final url = Api.getEmployees;

    final response = await _client.get(url);
    var listEmployees = <EmployeeModel>[];

    if (response.statusCode == 200 && response.data['success']) {
      if (response.data.containsKey("employees") &&
          response.data["employees"].isNotEmpty) {
        listEmployees = (response.data["employees"] as List)
            .map((e) => EmployeeModel.fromMap(e))
            .toList();
      }

      return listEmployees;
    } else {
      var msg = response.data['messageError'];
      throw DatasourceError(message: msg);
    }
  }

  @override
  Future<ResultModel> save(EmployeeModel model) async {
    final url = Api.saveEmployee;

    final response = await _client.post(url, data: model.toJson());

    if (response.statusCode == 200 && response.data['success']) {
      var model = ResultModel.fromMap(response.data);

      return model;
    } else {
      if (response.statusCode != 200) {
        throw DatasourceError(message: "Sistema temporariamente indisponível.");
      } else {
        var msg = response.data['messageError'];
        throw DatasourceError(message: msg);
      }
    }
  }

  @override
  Future<ResultModel> delete(int id) async {
    final url = Api.deleteEmployee;

    final response = await _client.post(url, queryParameters: {"id": id});

    if (response.statusCode == 200 && response.data['success']) {
      var model = ResultModel.fromMap(response.data);

      return model;
    } else {
      if (response.statusCode != 200) {
        throw DatasourceError(message: "Sistema temporariamente indisponível.");
      } else {
        var msg = response.data['messageError'];
        throw DatasourceError(message: msg);
      }
    }
  }
}
