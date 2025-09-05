import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/usecases/get_profile_shop.dart';
import '../stores/profileShop_store.dart';

class ProfileShopController {
  final GetProfileShop _getProfileShop;
  final ProfileShopStore store;
  bool loading = false;

  ProfileShopController(this._getProfileShop, this.store);

  Future<void> getProfile() async {
    loading = true;
    store.setProfile(await _getProfileShop.call());
    loading = false;
  }

  Future<void> editProfile() async {
    store.setImageLocal(null);
    Modular.to.pushNamed('editProfileShopPage', arguments: store.state);
  }
}
