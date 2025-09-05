import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../shared/components/default_dropdown_field/default_dropdown_field_widget.dart';
import '../../../../../../shared/components/loading_shimmer/shimmer_widget.dart';
import '../../../../../../shared/components/rounded_text_field/rounded_text_field_widget.dart';
import '../../../../../../shared/helpers/app_assets.dart';
import '../../../../../../shared/helpers/custom_colors.dart';
import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/helpers/utils.dart';
import '../../../start_sup/presenter/pages/startSup_controller.dart';
import '../stores/partnershipSup_store.dart';
import '../view_models/sup_view_model.dart';
import 'components/suppliers_tile_shop_widget.dart';
import 'partnershipSup_controller.dart';

class PartnershipSupPage extends StatefulWidget {
  final String title;
  const PartnershipSupPage({Key? key, this.title = 'Parceria Lojista'})
      : super(key: key);
  @override
  PartnershipSupPageState createState() => PartnershipSupPageState();
}

class PartnershipSupPageState extends State<PartnershipSupPage> {
  var controller = Modular.get<PartnershipSupController>();

  @override
  void initState() {
    super.initState();
    controller.refresh();
  }

  _showMessage() {
    var supName = controller.getSupName();
    final box = context.findRenderObject() as RenderBox?;
    var contentMsg =
        '$supName te convida a participar da nova plataforma de relacionamentos para o segmento de piscinas, XPool.\nVoce não paga nada por isso, é seguro e fácil de usar!!! E a cada indicação, voce ganha por isso.\nBaixe agora mesmo o aplicativo através do link, https://qrco.de/bdAapU e comece a indicar e ganhar.';

    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              contentPadding: EdgeInsets.all(20),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Share.share(contentMsg,
                          subject: "Convite para o XPool",
                          sharePositionOrigin:
                              box!.localToGlobal(Offset.zero) & box.size);
                    },
                    child: Text(
                      'COMPARTILHAR',
                      style: TextStyle(fontSize: 18),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('VOLTAR', style: TextStyle(fontSize: 18)))
              ],
              actionsAlignment: MainAxisAlignment.spaceEvenly,
              title: Center(child: Text("Compartilhar Convite")),
              content: Text(contentMsg),
            ));
  }

  _openFilter() {
    showMaterialModalBottomSheet(
        expand: true,
        enableDrag: false,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => SafeArea(
              bottom: false,
              child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  color: Colors.white,
                  child: TripleBuilder(
                      store: controller.filterStore,
                      builder: (context, triple) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 60,
                                    alignment: Alignment.centerLeft,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(Icons.close,
                                          size: 22,
                                          color: CustomColors.primary),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Filtrar por",
                                        style: TextStyle(
                                            color: CustomColors.darkBlue,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 60,
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Aplicar",
                                        style: TextStyle(
                                            color: CustomColors.primary,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 1,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Localidade",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DefaultDropDownFieldWidget(
                                  clearButton: true,
                                  getData: controller.getCitiesShop,
                                  onChanged: controller.setCity,
                                  selectedItem:
                                      controller.filterStore.state.city,
                                  fontColor: Colors.black.withOpacity(0.8),
                                  showSearchBox: true),
                              SizedBox(height: 20),
                              Text("Mostrar Parceiros"),
                              Switch(
                                  value:
                                      controller.filterStore.state.showPartners,
                                  onChanged: (v) {
                                    controller.filterStore.setShowPartners(v);
                                    controller.getShops();
                                  }),
                            ]);
                      })),
            ));
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
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.fromLTRB(10, 50, 10, 20),
              child: RoundedTextFieldWidget(
                prefixIcon: Icon(
                  Icons.search,
                  color: CustomColors.grey40,
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      //padding: EdgeInsets.all(0),
                      tooltip: "Filtro",
                      onPressed: _openFilter,
                      icon: Icon(Icons.tune),
                      color: CustomColors.grey40,
                    ),
                    IconButton(
                        visualDensity: VisualDensity.compact,
                        //padding: EdgeInsets.all(0),
                        tooltip: "Compartilhar",
                        onPressed: _showMessage,
                        icon: Icon(
                          Icons.share,
                          color: CustomColors.grey40,
                        )),
                  ],
                ),
                showBorder: false,
                backgroundColor: Colors.white.withOpacity(0.9),
                hintText: 'Encontre um parceiro',
                onChanged: (v) {
                  controller.store.setFilter(v!);
                },
              ),
              decoration: BoxDecoration(
                color: CustomColors.primary,
              )),
          Expanded(
            child: ScopedBuilder<PartnershipSupStore, Failure, SupVM>(
              store: controller.store,
              onLoading: (_) => Center(child: ShimmerWidget()),
              onError: (_, error) => Utils.buildError(
                  'Erro ao realizar busca: ${error?.message ?? ''}',
                  controller.refresh()),
              onState: (_, state) {
                if (state.shops.length == 0) {
                  return Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppAssets.partnershiplogo,
                            scale: 4,
                          ),
                          Text(
                            'Nenhum parceiro encontrado',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Text('Redefina sua busca')
                        ]),
                  );
                }

                return RefreshIndicator(
                  onRefresh: controller.getShops,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey.shade200,
                    ),
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 100),
                    itemCount: state.shopFiltered.length,
                    itemBuilder: (_, index) {
                      var shop = state.shopFiltered[index];

                      return ShopTileSupplier(
                        name: shop.name,
                        city: shop.city,
                        status: shop.status,
                        urlImage: shop.photo,
                        onPressedCreate: () {
                          controller.store.setStatus(index);
                          controller.createInvite(shop.id, index);
                        },
                        onPressedDelete: () {
                          controller.store.setStatus(index);
                          controller.cancelInvite(shop.id, index);
                        },
                        onPressedBreak: () {
                          controller.breakPartner(shop.id);
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
