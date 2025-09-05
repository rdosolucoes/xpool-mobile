import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/usecases/get_profile_sup.dart';
import '../../domain/usecases/interface/get_needs_sup_interface.dart';
import '../stores/profileSup_store.dart';

class ProfileSupController {
  final GetProfileSup _getProfileSup;
  final ProfileSupStore store;
  final IGetNeedsSup _getNeeds;
  bool loading = false;

  ProfileSupController(this._getProfileSup, this.store, this._getNeeds) {
    getProfile();
  }

  Future<void> getProfile() async {
    loading = true;
    store.setProfile(await _getProfileSup.call());
    loading = false;
  }

  Future<void> editProfile() async {
    var listSelNeeds = <int>[];
    store.setImageLocal(null);
    var needs = await _getNeeds.call();

    needs.fold(
        (l) => null,
        // ignore: avoid_function_literals_in_foreach_calls
        (r) => r.forEach((x) {
              if (x.active) {
                listSelNeeds.add(x.id);
              }
            }));

    store.setSelectedNeeds(listSelNeeds);
    store.setNeeds(needs);

    Modular.to.pushNamed('editProfileSupPage');
  }
}
