import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

import '../../../../../../shared/components/loading_shimmer/shimmer_widget_page.dart';
import '../../../../../../shared/helpers/app_assets.dart';
import '../../../../../../shared/helpers/custom_colors.dart';
import '../../../../../../shared/helpers/utils.dart';
import '../../../start_sup/presenter/pages/startSup_controller.dart';
import '../../domain/entities/myreference_sup_entity.dart';
import 'components/myReference_tile_sup_widget.dart';
import 'myReferenceSup_controller.dart';

class MyReferenceSupPage extends StatefulWidget {
  final String title;
  const MyReferenceSupPage({Key? key, this.title = 'Minhas Indicações'})
      : super(key: key);
  @override
  MyReferenceSupPageState createState() => MyReferenceSupPageState();
}

class MyReferenceSupPageState extends State<MyReferenceSupPage> {
  var controller = Modular.get<MyReferenceSupController>();

  static const _pageSize = 10;

  final PagingController<int, MyReferenceSupEntity> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener(_fetchPage);
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await controller.getReferencesPage(
          pageKey, _pageSize); //RemoteApi.getCharacterList(pageKey, _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } on Exception catch (error) {
      _pagingController.error = error;
    }
  }

  Future<void> setDoneDeal(int value, int referenceId) async {
    await controller.setDoneDeal(value, referenceId);
    Future.sync(
      _pagingController.refresh,
    );
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
            body: Container(
              margin: EdgeInsets.only(top: 10),
              child: RefreshIndicator(
                onRefresh: () => Future.sync(
                  _pagingController.refresh,
                ),
                child: PagedListView<int, MyReferenceSupEntity>.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  pagingController: _pagingController,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 100),
                  builderDelegate:
                      PagedChildBuilderDelegate<MyReferenceSupEntity>(
                    firstPageErrorIndicatorBuilder: (_) => Utils.buildError(
                      _pagingController.error,
                      _pagingController.refresh(),
                    ),
                    newPageErrorIndicatorBuilder: (_) => Utils.buildError(
                      _pagingController.error,
                      _pagingController.refresh(),
                    ),
                    noItemsFoundIndicatorBuilder: (_) => Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppAssets.partnershiplogo,
                              scale: 4,
                            ),
                            Text(
                              'Nenhuma indicação encontrada',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Text('Você ainda não aprovou nenhuma indicação.'),
                            TextButton(
                                onPressed: _pagingController.refresh,
                                child: Icon(
                                  Icons.update,
                                  size: 30,
                                ))
                          ]),
                    ),
                    firstPageProgressIndicatorBuilder: (_) =>
                        Center(child: ShimmerWidgetPage()),
                    animateTransitions: true,
                    itemBuilder: (context, item, index) {
                      var canContest = true;
                      var currentDate = DateTime.now();
                      var parsedDate = DateFormat('dd/MM/yyyy hh:mm:ss')
                          .parse(item.dateHour);

                      var periodDate = parsedDate.add(Duration(days: 1));

                      if (currentDate.isAfter(periodDate)) canContest = false;

                      return MyReferenceTileSup(
                        referenceId: item.id,
                        shopName: item.shopName,
                        shopLogo: item.shopLogo,
                        customerName: item.customerName,
                        customerPhone: item.customerPhone,
                        dateReference: item.dateHour,
                        needDescription: item.needDescription,
                        taskDescription: item.taskDescription,
                        needIcon: item.iconNeed,
                        canContest: canContest,
                        localMainText: item.localMainText,
                        localSecondaryText: item.localSecondaryText,
                        latitude: item.latitude,
                        longitude: item.longitude,
                        pressSendDispute: controller.createDispute,
                        pressSetDoneDeal: setDoneDeal,
                        status: item.status,
                        doneDeal: item.doneDeal,
                        reply: item.reply,
                      );
                    },
                  ),
                ),
              ),
            )));
  }
}
