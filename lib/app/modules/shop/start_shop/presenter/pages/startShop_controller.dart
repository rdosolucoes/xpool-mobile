import '../../../../../../shared/usecases/get_count_notifications.dart';
import '../../domain/usecases/interfaces/get_needs_interface.dart';
import '../stores/need_store.dart';
import '../stores/startShop_store.dart';

class StartShopController {
  final StartShopStore store;
  final IGetNeeds _getNeeds;
  final GetCountNotifications _getCountNotifications;
  NeedStore needStore;

  StartShopController(
      this.store, this.needStore, this._getNeeds, this._getCountNotifications) {
    getNeeds();
  }

  void setCurrentTabIndex(int v) => store.setCurrentTabIndex(v);
  void setNotifyCount(int v) => store.setNotifyCount(v);
  int getNotifyCount() => store.state.notifyCount;

  Future<void> getNeeds() async {
    needStore.setNeeds(_getNeeds());
  }

  Future<int> getCountNotifications() async {
    var result = await _getCountNotifications.call();
    var count = 0;

    result.fold((l) => null, (r) => count = r);

    return count;
  }
}
