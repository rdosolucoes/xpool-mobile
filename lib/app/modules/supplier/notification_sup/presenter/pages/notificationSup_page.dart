import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import '../../../../../../shared/components/loading_shimmer/shimmer_widget.dart';

import '../../../../../../shared/helpers/app_assets.dart';
import '../../../../../../shared/helpers/custom_colors.dart';
import '../../../../../../shared/helpers/enum.dart';
import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/helpers/utils.dart';
import '../../../start_sup/presenter/pages/startSup_controller.dart';
import '../stores/notificationSup_store.dart';
import '../view_models/notification_view_model.dart';
import 'components/notification_tile_advice_sup_widget.dart';
import 'components/notification_tile_invite_sup_widget.dart';
import 'notificationSup_controller.dart';

class NotificationSupPage extends StatefulWidget {
  final String title;
  const NotificationSupPage({Key? key, this.title = 'Notificações'})
      : super(key: key);
  @override
  NotificationSupPageState createState() => NotificationSupPageState();
}

class NotificationSupPageState extends State<NotificationSupPage> {
  var controller = Modular.get<NotificationSupController>();
  @override
  void initState() {
    controller.updateNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var tabController = Modular.get<StartSupController>();
        tabController.setCurrentTabIndex(0);
        Modular.to.navigate('/startSup/homeSup');
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: CustomColors.primary,
            centerTitle: true,
            title: Text(
              widget.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            // centerTitle: true,
          ),
          body: ScopedBuilder<NotificationSupStore, Failure, NotificationVM>(
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
                      return NotificationTileInviteSup(
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
                      return NotificationTileAdviceSup(
                          name: notification.name!,
                          message: notification.message!,
                          dateHour: notification.dateHour!,
                          urlImage: notification.photo!);
                    }
                  },
                ),
              );
            },
          )),
    );
  }
}
