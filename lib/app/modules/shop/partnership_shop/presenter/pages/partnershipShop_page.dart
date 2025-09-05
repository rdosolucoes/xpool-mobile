import 'dart:io';

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
import '../../../../../../shared/needs/domain/entity/need_entity.dart';
import '../../../start_shop/presenter/pages/startShop_controller.dart';
import '../stores/partnershipShop_store.dart';
import '../view_models/supplier_view_model.dart';
import 'components/suppliers_tile_shop_widget.dart';
import 'partnershipShop_controller.dart';

class PartnershipShopPage extends StatefulWidget {
  final String title;
  const PartnershipShopPage({Key? key, this.title = 'Parceria Lojista'})
      : super(key: key);
  @override
  PartnershipShopPageState createState() => PartnershipShopPageState();
}

class PartnershipShopPageState extends State<PartnershipShopPage> {
  var controller = Modular.get<PartnershipShopController>();
  var shopName = "";

  @override
  void initState() {
    super.initState();
    controller.refresh();
  }

  _showMessage() {
    shopName = controller.getShopName();
    final box = context.findRenderObject() as RenderBox?;
    var contentMsg =
        'A $shopName te convida a participar da nova plataforma de lojas e prestadores de serviço do segmento de piscinas, XPool, pois a partir de agora todas as indicações de clientes serão enviadas pelo aplicativo.\nBaixe agora mesmo, através do link, https://qrco.de/bdAapU e receba indicações para aumentar sua carteira de clientes.';

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
                                    padding: EdgeInsets.only(right: 5),
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
                                  //labelText: 'Cidade',
                                  clearButton: true,
                                  getData: controller.getCitiesSup,
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
                                    controller.getSuppliers();
                                  }),
                              SizedBox(height: 20),
                              Text(
                                "Serviços prestados",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: Container(
                                    padding: EdgeInsets.only(
                                      top: 5,
                                    ),
                                    child: TripleBuilder(
                                      store: controller.filterStore,
                                      builder: (context, triple) {
                                        return SingleChildScrollView(
                                          child: Wrap(
                                              spacing: 4.0,
                                              runSpacing: 2.0,
                                              children: _buildChip(
                                                  controller.filterStore.error
                                                      ?.message,
                                                  controller.filterStore.state
                                                      .listNeeds)),
                                        );
                                      },
                                    )),
                              ),
                            ]);
                      })),
            ));
  }

  @override
  Widget build(BuildContext context) {
    var bottomFloat = 53.0;

    if (Platform.isIOS) {
      bottomFloat = bottomFloat + 30;
    }

    return WillPopScope(
      onWillPop: () async {
        var tabController = Modular.get<StartShopController>();
        tabController.setCurrentTabIndex(0);
        Modular.to.navigate('/startShop/homeShop');
        return false;
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
                  mainAxisAlignment: MainAxisAlignment.end,
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
          SizedBox(height: 10),
          Expanded(
            child: ScopedBuilder<PartnershipShopStore, Failure, SupplierVM>(
              store: controller.store,
              onLoading: (_) => Center(child: ShimmerWidget()),
              onError: (_, error) => Utils.buildError(
                  'Erro ao realizar busca: ${error?.message ?? ''}',
                  controller.getSuppliers()),
              onState: (_, state) {
                if (state.suppliers.length == 0) {
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
                  onRefresh: controller.getSuppliers,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey.shade200,
                    ),
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 90),
                    itemCount: state.supplierFiltered.length,
                    itemBuilder: (_, index) {
                      var supplier = state.supplierFiltered[index];

                      return SupplierTileShop(
                        name: supplier.name,
                        city: supplier.city,
                        status: supplier.status,
                        urlImage: supplier.photo,
                        needs: supplier.needs,
                        onPressedCreate: () {
                          controller.store.setStatus(index);
                          controller.createInvite(supplier.id, index);
                        },
                        onPressedDelete: () {
                          controller.store.setStatus(index);
                          controller.cancelInvite(supplier.id, index);
                        },
                        onPressedBreak: () {
                          controller.breakPartner(supplier.id);
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

  List<Widget> _buildChip(String? messageError, List<NeedEntity> model) {
    var listItem = <FilterChip>[];

    listItem = model
        .map((e) => FilterChip(
              pressElevation: 5,
              shadowColor: CustomColors.darkBlue,
              backgroundColor: Colors.grey[100],
              label: Text(
                e.description,
              ),
              labelStyle: controller.filterStore.existNeed(e.id)
                  ? TextStyle(color: Colors.white)
                  : TextStyle(color: Colors.black),
              selected: controller.filterStore.existNeed(e.id),
              selectedColor: CustomColors.blueBar,
              showCheckmark: false,
              onSelected: (v) {
                if (v) {
                  controller.filterStore.addNeed(e.id);
                  controller.getSuppliers();
                } else {
                  controller.filterStore.removeNeed(e.id);
                  controller.getSuppliers();
                }
              },
            ))
        .toList();

    return listItem;
  }
}
