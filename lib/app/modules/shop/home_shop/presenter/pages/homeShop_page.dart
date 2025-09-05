import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:intl/intl.dart';

import '../../../../../../shared/components/loading_shimmer/shimmer_widget.dart';
import '../../../../../../shared/helpers/app_assets.dart';
import '../../../../../../shared/helpers/consts.dart';
import '../../../../../../shared/helpers/custom_colors.dart';
import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/helpers/utils.dart';
import '../../domain/entities/values_header_entity.dart';
import '../stores/headerShop_store.dart';
import '../stores/homeShop_store.dart';
import '../view_model/home_view_model.dart';
import 'components/cards/card_status_widget.dart';
import 'components/cards/cards_home_widget.dart';
import 'components/header/header_home_widget.dart';
import 'components/list/reference_tile_widget.dart';
import 'homeShop_controller.dart';

class HomeShopPage extends StatefulWidget {
  final String title;
  const HomeShopPage({Key? key, this.title = 'Home Lojista'}) : super(key: key);
  @override
  HomeShopPageState createState() => HomeShopPageState();
}

class HomeShopPageState extends State<HomeShopPage> {
  late Timer _timer;
  var controller = Modular.get<HomeShopController>();

  @override
  void initState() {
    var time = 60;

    controller.refreshValues();

    _timer = Timer.periodic(Duration(seconds: time), (t) {
      controller.refreshValues();
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var logo = controller.authStore.state.image;
    var currDate = DateTime.now();

    var month = DateFormat("MMMM", "pt_BR")
        .format(currDate)
        .substring(0, 3)
        .toUpperCase();

    var year = DateFormat("yy", "pt_BR").format(currDate);

    var formatDate = '$month/$year';

    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            height: size.height,
            child: Stack(children: [
              ScopedBuilder<HeaderShopStore, Failure, ValuesHeaderEntity>(
                  store: controller.storeHeader,
                  onLoading: (_) => Center(child: ShimmerWidget()),
                  onError: (_, error) => Utils.buildError(
                      'Erro ao atualizar saldos ${error?.message ?? ''}',
                      controller.refreshValues()),
                  onState: (_, state) {
                    return Stack(children: <Widget>[
                      Row(
                        children: [
                          Expanded(
                            child: HeaderHomeWidget(
                                saldo: state.saldo,
                                isEmployee:
                                    controller.authStore.state.isEmployee,
                                title: controller.authStore.state.name ?? "",
                                logo: logo == null || logo.isEmpty
                                    ? imageDefault
                                    : logo),
                          ),
                        ],
                      ),
                      CardsHomeWidget(
                        totalReferences: state.totalReference,
                        totalAccept: state.totalAccept,
                        totalReject: state.totalReject,
                        isEmployee: controller.authStore.state.isEmployee,
                      ),
                    ]);
                  }),
              Positioned.fill(
                top: 300,
                child: Container(
                  margin: EdgeInsets.only(bottom: 45, top: 10),
                  padding: EdgeInsets.only(top: 10),
                  //height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                  ),

                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    child: ScopedBuilder<HomeShopStore, Failure, HomeVM>(
                      store: controller.store,
                      onLoading: (_) => Center(child: ShimmerWidget()),
                      onError: (_, error) => Utils.buildError(
                          'Erro ao realizar busca: ${error?.message ?? ''}',
                          controller.refreshValues()),
                      onState: (_, state) {
                        if (state.references.length == 0) {
                          return Center(
                            child: Container(
                              margin: EdgeInsets.only(
                                  bottom: 10, left: 60, right: 60),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      AppAssets.noresult,
                                      scale: 7,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Nada Encontrado.',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: CustomColors.primary),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Faça novas parcerias e aumente suas indicações !',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: CustomColors.darkBlue,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    TextButton(
                                        onPressed: controller.getReferences,
                                        child: Icon(
                                          Icons.update,
                                          size: 30,
                                        ))
                                  ]),
                            ),
                          );
                        }
                        return RefreshIndicator(
                          onRefresh: controller.getReferences,
                          child: ListView.separated(
                            separatorBuilder: (context, index) => Divider(
                              color: Colors.grey.shade200,
                            ),
                            padding: EdgeInsets.only(top: 10, bottom: 50),
                            itemCount: state.references.length,
                            itemBuilder: (_, index) {
                              var reference = state.references[index];

                              return ReferenceTile(
                                referenceId: reference.id,
                                suppliers: reference.suppliers,
                                dateHour: reference.dateHour,
                                need: reference.need,
                                customerName: reference.customerName,
                                iconNeed: reference.iconNeed,
                                localMainText: reference.localMainText,
                                localSecondaryText:
                                    reference.localSecondaryText,
                                totalReference:
                                    reference.totalReference.toString(),
                                totalAccept: reference.totalAccept.toString(),
                                totalReject: reference.totalReject.toString(),
                                totalContest: reference.totalContest.toString(),
                                status: reference.status,
                                employee: reference.employee,
                                deleteReference: () =>
                                    controller.deleteReference(reference.id),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                  left: 15,
                  width: size.width,
                  top: 226,
                  child: Text(
                    "Lista de Indicações",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  )),
              Positioned(
                  left: size.width - 86,
                  width: size.width,
                  top: 230,
                  child: Text(
                    formatDate,
                    style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      // decoration: TextDecoration.underline,
                    ),
                  )),
              Positioned(
                width: size.width,
                top: 265,
                child: TripleBuilder(
                    store: controller.store,
                    builder: (context, triple) {
                      return Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                controller.store.setFilterType(0);
                                controller.getReferences();
                              },
                              child: CardStatusWidget(
                                  label: "Pendentes",
                                  value: controller.storeHeader.state.refpend,
                                  active:
                                      controller.store.state.filterType == 0),
                            ),
                            InkWell(
                              onTap: () {
                                controller.store.setFilterType(1);
                                controller.getReferences();
                              },
                              child: CardStatusWidget(
                                  label: "Aceitas",
                                  value: controller.storeHeader.state.refAccept,
                                  active:
                                      controller.store.state.filterType == 1),
                            ),
                            InkWell(
                              onTap: () {
                                controller.store.setFilterType(2);
                                controller.getReferences();
                              },
                              child: CardStatusWidget(
                                  label: "Expiradas",
                                  value:
                                      controller.storeHeader.state.refExpired,
                                  active:
                                      controller.store.state.filterType == 2),
                            ),
                          ],
                        ),
                      );
                    }),
              )
            ]),
          ),
        ));
  }
}
