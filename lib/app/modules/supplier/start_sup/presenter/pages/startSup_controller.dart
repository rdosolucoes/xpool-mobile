import '../../../../../../shared/usecases/get_count_notifications.dart';
import '../stores/startSup_store.dart';

class StartSupController {
  final StartSupStore store;
  final GetCountNotifications _getCountNotifications;

  StartSupController(
    this.store,
    this._getCountNotifications,
  ) {
    getCountNotifications();
  }

  void setCurrentTabIndex(int v) => store.setCurrentTabIndex(v);
  void setNotifyCount(int v) => store.setNotifyCount(v);
  int getNotifyCount() => store.state.notifyCount;

  Future<int> getCountNotifications() async {
    var result = await _getCountNotifications.call();
    var count = 0;

    result.fold((l) => null, (r) => count = r);

    return count;
  }
}
