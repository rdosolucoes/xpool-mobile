import '../../models/partner_sup_model.dart';

abstract class IPartnerSupDataSource {
  Future<List<PartnerSupModel>> get();
}
