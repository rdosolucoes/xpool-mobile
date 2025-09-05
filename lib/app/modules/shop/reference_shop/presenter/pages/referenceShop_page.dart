import 'dart:io';

import 'package:asuka/asuka.dart' as asuka;
import 'package:brasil_fields/brasil_fields.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../../../shared/components/default_flat_button/default_flat_button_widget.dart';
import '../../../../../../shared/components/loading_shimmer/shimmer_widget.dart';
import '../../../../../../shared/components/places_auto_complete_field/places_auto_complete_field_widget.dart';
import '../../../../../../shared/helpers/app_assets.dart';
import '../../../../../../shared/helpers/custom_colors.dart';
import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/helpers/utils.dart';
import '../../../../../../shared/needs/domain/entity/need_entity.dart';
import '../../../start_shop/presenter/pages/startShop_controller.dart';
import '../stores/supplierReferenceShop_store.dart';
import '../view_models/supplier_view_model.dart';
import 'components/filter_item_shop_widget.dart';
import 'components/supplier_tile_reference_widget.dart';
import 'referenceShop_controller.dart';

const kGoogleApiKey = 'AIzaSyAYMSY_9jre3PQwxjKcUGrnRy1I-0HfV6c';

class ReferenceShopPage extends StatefulWidget {
  final String title;

  ReferenceShopPage({Key? key, this.title = 'Indicação Lojista'})
      : super(key: key);
  @override
  ReferenceShopPageState createState() => ReferenceShopPageState();
}

class ReferenceShopPageState extends State<ReferenceShopPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var controller = Modular.get<ReferenceShopController>();

  void onPageChange(int index, CarouselPageChangedReason changeReason) {
    controller.setFilterActiveIndex(index);
  }

  Future<void> onPressed() async {
    var model = controller.store.state;
    var messageSup = "fornecedor selecionado.";
    var countSup = controller.getCountCheckedSup();

    if (countSup > 1) {
      messageSup = "fornecedores selecionados";
    }

    if (model.supIds!.isEmpty) {
      asuka.showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text("Nenhum Fornecedor Selecionado. Verifique!"),
      ));
      return;
    }

    showMaterialModalBottomSheet(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        elevation: 5,
        context: context,
        builder: (context) => SafeArea(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Dados da Indicação",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        //SizedBox(height: 10),
                        Text(
                          controller.getNeedDescription(),
                          style: TextStyle(fontSize: 14),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            "$countSup $messageSup",
                            style: TextStyle(
                                fontSize: 14,
                                color: CustomColors.primary,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                PlacesAutoCompleteFieldWidget(
                                  controller: TextEditingController(
                                      text: controller.getLocalization()),
                                  onChanged: controller.setLocalization,
                                  validator: (value) {
                                    return value!.isNotEmpty
                                        ? null
                                        : "Informe a Localização";
                                  },
                                ),
                                TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  scrollPadding: EdgeInsets.only(top: 50),
                                  onChanged: controller.setName,
                                  validator: (value) {
                                    return value!.isNotEmpty
                                        ? null
                                        : "Informe o Cliente";
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Nome Cliente',
                                  ),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.phone,
                                  onChanged: controller.setPhone,
                                  validator: (value) {
                                    return value!.isNotEmpty
                                        ? null
                                        : "Informe o Contato";
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    TelefoneInputFormatter(),
                                  ],
                                  decoration: InputDecoration(
                                    labelText: 'Contato',
                                  ),
                                ),
                                TextFormField(
                                  onChanged: controller.setDescription,
                                  maxLength: 150,
                                  maxLines: 3,
                                  validator: (value) {
                                    return value!.isNotEmpty
                                        ? null
                                        : "Informe a Descrição do Serviço";
                                  },
                                  //keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    labelText: 'Descrição do Serviço',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 30, bottom: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              DefaultFlatButtonWidget(
                                  label: "Confirmar",
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      FocusScope.of(context).unfocus();

                                      if (!controller.hasBankAccount()) {
                                        showDialog(
                                          barrierDismissible: true,
                                          context: context,
                                          builder: (context) => AlertDialog(
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      Modular.to.pushNamed(
                                                          '/bankAccount',
                                                          arguments: {
                                                            'index': controller
                                                                .filterActiveIndex
                                                          });
                                                    },
                                                    child: Text(
                                                      'SIM',
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    )),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('NÃO',
                                                        style: TextStyle(
                                                            fontSize: 18)))
                                              ],
                                              contentPadding:
                                                  EdgeInsets.all(15),
                                              actionsAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              title:
                                                  Center(child: Text("Aviso")),
                                              content: Text(
                                                  'Você precisa definir uma conta bancária para continuar. Deseja fazer isso agora?')),
                                        );
                                        return;
                                      }
                                      controller.createReference();
                                    }
                                  }) //,
                              /*   TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Voltar")),*/
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var bottomFloat = 35.0;

    if (Platform.isIOS) {
      bottomFloat = bottomFloat * 2;
    }

    return WillPopScope(
      onWillPop: () async {
        var tabController = Modular.get<StartShopController>();
        tabController.setCurrentTabIndex(0);
        Modular.to.navigate('/startShop/homeShop');
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: Container(
          margin: EdgeInsets.only(bottom: bottomFloat),
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            onPressed: onPressed,
            child: const FaIcon(FontAwesomeIcons.plus, color: Colors.white),
            //color: Colors.white,
            //size: 20,
            // ),
            backgroundColor: CustomColors.primary,
          ),
        ),
        body: Stack(
          children: [
            Positioned(
              left: -70,
              top: -50,
              child: Container(
                width: size.width + 100,
                height: size.height * 0.35,
                decoration: BoxDecoration(
                    color: CustomColors.primary,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(200),
                        bottomRight: Radius.circular(240))),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Para qual serviço vai indicar ?',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 24)),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: TripleBuilder(
                      store: controller.needStore,
                      builder: (context, triple) {
                        return buildForm(controller.needStore.error?.message,
                            controller.needStore.state.listNeeds);
                      },
                    )),
                Container(
                  padding: EdgeInsets.only(left: 15, top: 15, bottom: 5),
                  alignment: Alignment.bottomLeft,
                  child: Text("Lista de Parceiros",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: CustomColors.darkBlue)),
                ),
                Expanded(
                  //height: size.height * 0.35,
                  child: ScopedBuilder<SupplierReferenceShopStore, Failure,
                      SupplierVM>(
                    store: controller.supStore,
                    onLoading: (_) => Center(child: ShimmerWidget()),
                    onError: (_, error) => Utils.buildError(
                        'Erro ao realizar busca: ${error?.message ?? ''}',
                        controller.getReferenceSuppliers(
                            controller.filterActiveIndex)),
                    onState: (_, state) {
                      if (state.suppliers.length == 0) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 60),
                              Image.asset(
                                AppAssets.noresult,
                                scale: 5,
                              ),
                              Container(
                                //padding: EdgeInsets.only(top: 100),
                                child: Text(
                                  'Nenhum Parceiro Encontrado',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return RefreshIndicator(
                        onRefresh: () {
                          return controller.setFilterActiveIndex(
                              controller.filterActiveIndex);
                        },
                        child: ListView.builder(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 120),
                          itemCount: state.supplierFiltered.length,
                          itemBuilder: (_, index) {
                            var supplier = state.supplierFiltered[index];

                            return SupplierTileReference(
                              name: supplier.name,
                              city: supplier.city,
                              checked: supplier.checked,
                              urlImage: supplier.photo,
                              totalReference: supplier.totalReference,
                              totalAccept: supplier.totalAccept,
                              totalReject: supplier.totalReject,
                              onChanged: (value) {
                                controller.setCheck(index, value);
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
          ],
        ),
      ),
    );
  }

  Widget buildForm(String? messageError, List<NeedEntity> model) {
    var listItem = <FilterItemShopWidget>[];

    listItem = model
        .map((e) => FilterItemShopWidget(
              translateKey: e.description,
              iconAsset: e.image,
              isActive: true,
            ))
        .toList();

    return CarouselSlider(
        options: CarouselOptions(
            initialPage: controller.filterActiveIndex,
            height: MediaQuery.of(context).size.height * 0.22,
            autoPlay: false,
            aspectRatio: 2.15,
            enlargeCenterPage: true,
            onPageChanged: onPageChange,
            viewportFraction: .4),
        items: listItem);
  }
}
