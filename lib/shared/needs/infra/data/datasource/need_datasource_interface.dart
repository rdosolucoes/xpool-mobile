import '../../model/need_model.dart';

abstract class INeedDatasource {
  Future<List<NeedModel>> get();
}
