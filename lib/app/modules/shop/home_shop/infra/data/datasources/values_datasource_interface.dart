import '../../models/values_model.dart';

abstract class IValuesDataSource {
  Future<ValuesModel> get();
}
