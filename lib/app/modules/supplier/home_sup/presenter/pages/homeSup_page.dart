import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
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
import '../../domain/entities/partner_sup_entity.dart';
import '../stores/homeSup_store.dart';
import '../view_model/home_view_model.dart';
import 'components/cards/card_values_widget.dart';
import 'components/carousel/list_partners_sup_widget.dart';
import 'components/header/header_home_widget.dart';
import 'components/list/reference_sup_tile_widget.dart';
import 'homeSup_controller.dart';

class HomeSupPage extends StatefulWidget {
  final String title;
  const HomeSupPage({Key? key, this.title = 'Home Fornecedor'})
      : super(key: key);
  @override
  HomeSupPageState createState() => HomeSupPageState();
}

class HomeSupPageState extends State<HomeSupPage> {
  late Timer _timer;
  var controller = Modular.get<HomeSupController>();

  @override
  void initState() {
    controller.refreshValues();
    var time = 60;
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
            Stack(children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: HeaderHomeWidget(
                        title: controller.authStore.state.name ?? "",
                        logo: logo == null || logo.isEmpty
                            ? imageDefaultSup
                            : logo),
                  ),
                ],
              ),
            ]),
            Positioned.fill(
                top: 260,
                child: Container(
                  margin: EdgeInsets.only(bottom: 45, top: 5),
                  padding: EdgeInsets.only(top: 60),
                  height: size.height,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                  ),
                  child: ScopedBuilder<HomeSupStore, Failure, HomeSupVM>(
                    store: controller.store,
                    onLoading: (_) => ShimmerWidget(),
                    onError: (_, error) => Utils.buildError(
                        'Erro ao realizar busca: ${error?.message ?? ''}',
                        controller.refreshValues()),
                    onState: (_, state) {
                      if (state.references.length == 0) {
                        return Center(
                          child: Container(
                            margin: EdgeInsets.only(
                                bottom: 30, left: 80, right: 80),
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
                                    'Faça novas parcerias e aumente suas indicações.',
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
                            padding: EdgeInsets.all(0),
                            itemCount: state.references.length,
                            itemBuilder: (_, index) {
                              var reference = state.references[index];

                              return ReferenceSupTile(
                                  acceptReference: () {
                                    controller.acceptReference(reference.id);
                                    Navigator.pop(context);
                                  },
                                  rejectReference: () {
                                    controller.rejectReference(reference.id);
                                    Navigator.pop(context);
                                  },
                                  integrationId: reference.id,
                                  context: context,
                                  userOrig: reference.userOrig,
                                  urlLogo: reference.urlLogo,
                                  dateHour: reference.dateHour,
                                  description: reference.description,
                                  need: reference.need,
                                  localMainText: reference.localMainText,
                                  localSecondaryText:
                                      reference.localSecondaryText,
                                  latitude: reference.latitude,
                                  longitude: reference.longitude,
                                  iconNeed: reference.iconNeed,
                                  totalReference:
                                      reference.totalReference.toString(),
                                  totalAccept: reference.totalAccept.toString(),
                                  totalReject: reference.totalReject.toString(),
                                  cardDefault:
                                      controller.storeHeader.state.cardDefault,
                                  refValue:
                                      controller.storeHeader.state.refValue);
                            },
                          ));
                    },
                  ),
                )),
            Positioned(
                left: size.width - 60,
                width: size.width,
                top: size.height * 0.05,
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
              top: 220,
              child: TripleBuilder(
                  store: controller.storeHeader,
                  builder: (context, triple) {
                    return Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CardValuesWidget(
                              label: "Pendentes",
                              value:
                                  controller.storeHeader.state.totalReference,
                              active: true),
                          CardValuesWidget(
                              label: "Aceitas",
                              value: controller.storeHeader.state.totalAccept,
                              active: true),
                          CardValuesWidget(
                            label: "Rejeitadas",
                            value: controller.storeHeader.state.totalReject,
                            active: true,
                          ),
                        ],
                      ),
                    );
                  }),
            )
          ]),
        ),
      ),
    );
  }
}

Widget buildForm(String? messageError, List<PartnerSupEntity> model) {
  var listItem = <ListPartnersSupWidget>[];
  var viewportFraction = 1.0;
  var enableInfiniteScroll = false;

  if (model.length > 1) {
    enableInfiniteScroll = true;
  }

  if (model.length > 2) {
    viewportFraction = 0.4;
  }

  listItem = model
      .map((e) => ListPartnersSupWidget(
            name: e.name,
            photo: e.photo,
          ))
      .toList();

  if (listItem.length == 0) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(8),
              child: Image.asset(
                AppAssets.partnershiplogo,
                scale: 3,
              ),
            ),
            Text(
              "Nenhum parceiro encontrado.",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(
              "Faça parceiros para começar a indicar.",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  } else {
    return Column(children: [
      SizedBox(height: 15),
      Column(
        children: [
          Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(top: 10, left: 5),
              child: Text(
                "Parceiros",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: CustomColors.darkBlue),
              )),
        ],
      ),
      CarouselSlider(
          options: CarouselOptions(
              disableCenter: true,
              initialPage: 0, //controller.filterActiveIndex,
              autoPlay: true,
              aspectRatio: 2.15,
              enlargeCenterPage: true,
              enableInfiniteScroll: enableInfiniteScroll,
              //onPageChanged: (){},
              viewportFraction: viewportFraction),
          items: listItem),
    ]);
  }
}
