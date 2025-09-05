import '../../models/supplier_reference_model.dart';

abstract class ISupplierReferenceDatasource {
  Future<List<SupplierReferenceModel>> getByNeed(int needId);
}
