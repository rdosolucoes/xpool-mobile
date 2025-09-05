import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import '../../../../../../shared/components/loading_shimmer/shimmer_widget.dart';

import '../../../../../../shared/helpers/app_assets.dart';
import '../../../../../../shared/helpers/custom_colors.dart';
import '../../../../../../shared/helpers/enum.dart';
import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/helpers/utils.dart';
import '../../../start_shop/presenter/pages/startShop_controller.dart';
import '../stores/notificationShop_store.dart';
import '../view_models/notification_shop_view_model.dart';
import 'components/notification_tile_advice_shop_widget.dart';
import 'components/notification_tile_invite_shop_widget.dart';
import 'notificationShop_controller.dart';

class NotificationShopPage extends StatefulWidget {
  final String title;
  const NotificationShopPage({Key? key, this.title = 'Notificações'})
      : super(key: key);
  @override
  NotificationShopPageState createState() => NotificationShopPageState();
}

class NotificationShopPageState extends State<NotificationShopPage> {
  var controller = Modular.get<NotificationShopController>();
  @override
  void initState() {
    controller.updateNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var tabController = Modular.get<StartShopController>();
        tabController.setCurrentTabIndex(0);
        Modular.to.navigate('/startShop/homeShop');
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: CustomColors.primary,
            title: Text(
              widget.title,
              style: TextStyle(fontSize: 24),
            ),
            // centerTitle: true,
          ),
          body:
              ScopedBuilder<NotificationShopStore, Failure, NotificationShopVM>(
            store: controller.store,
            onLoading: (_) => Center(child: ShimmerWidget()),
            onError: (_, error) => Utils.buildError(
                'Erro ao realizar busca: ${error?.message ?? ''}',
                controller.getNotifications()),
            onState: (_, state) {
              if (state.notifications.length == 0) {
                return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppAssets.noNotifications,
                          scale: 12,
                          //height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'Nenhuma notificação encontrada',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                        TextButton(
                            onPressed: controller.getNotifications,
                            child: Icon(
                              Icons.update,
                              size: 30,
                            ))
                      ]),
                );
              }

              return RefreshIndicator(
                onRefresh: controller.getNotifications,
                child: ListView.builder(
                  itemCount: state.notificationFiltered.length,
                  itemBuilder: (_, index) {
                    var notification = state.notificationFiltered[index];

                    if (notification.type == ETypeNotification.invite) {
                      return NotificationTileInviteShop(
                          name: notification.name!,
                          message: notification.message!,
                          city: notification.cityState!,
                          status: notification.status,
                          dateHour: notification.dateHour!,
                          urlImage: notification.photo!,
                          onPressedConfirm: () {
                            controller.store.setStatus(index, 1);
                            controller.confirmInvite(notification.id!, index);
                          },
                          onPressedReject: () {
                            controller.store.setStatus(index, 2);
                            controller.rejectInvite(notification.id!, index);
                          });
                    } else {
                      return NotificationTileAdviceShop(
                        name: notification.name!,
                        message: notification.message!,
                        dateHour: notification.dateHour!,
                        urlImage: notification.photo!,
                      );
                    }
                  },
                ),
              );
            },
          )),
    );
  }
}
