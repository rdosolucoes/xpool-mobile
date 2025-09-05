import '../../models/need_sup_model.dart';
import '../../models/profile_sup_model.dart';

abstract class IProfileSupDataSource {
  Future<ProfileSupModel> get();

  //Future<String> uploadImage(dynamic filePath);

  Future<ProfileSupModel> postProfile(ProfileSupModel model);

  Future<List<NeedSupModel>> getNeeds();
}
