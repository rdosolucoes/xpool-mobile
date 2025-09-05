import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../../../shared/helpers/custom_colors.dart';
import '../../domain/entities/profile_shop_entity.dart';
import '../widgets/profile_widget.dart';
import '../widgets/textfield_widget.dart';
import 'edit_profileShop_controller.dart';
import 'profileShop_controller.dart';

class EditProfileShopPage extends StatefulWidget {
  final String title;
  final ProfileShopEntity model;

  const EditProfileShopPage(
      {Key? key, this.title = 'Meu Perfil', required this.model})
      : super(key: key);
  @override
  EditProfileShopPageState createState() => EditProfileShopPageState();
}

class EditProfileShopPageState extends State<EditProfileShopPage> {
  var controller = Modular.get<EditProfileShopController>();
  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Edição de Perfil'),
              content: Text('Deseja sair sem salvar suas alterações?'),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    var profileController =
                        Modular.get<ProfileShopController>();
                    profileController
                        .getProfile()
                        .whenComplete(() => Navigator.of(context).pop(true));
                  },
                  //return false when click on "NO"
                  child: Text('Sim', style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),

                  //return true when click on "Yes"
                  child: Text('Não', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    return WillPopScope(
        onWillPop: showExitPopup,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Editar Perfil",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            leading: BackButton(color: Colors.white),
            backgroundColor: CustomColors.primary,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.check, color: Colors.white),
                tooltip: 'Salvar Alterações',
                onPressed: () {
                  controller.save(controller.store.state);
                },
              ),
            ],
          ),
          body: TripleBuilder(
              store: controller.store,
              builder: (context, triple) {
                var profile = controller.store.state;

                return ListView(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  physics: BouncingScrollPhysics(),
                  children: [
                    ProfileWidget(
                        imagePath: profile.image,
                        imageLocal: profile.imageLocal == null
                            ? ""
                            : profile.imageLocal!.path,
                        isEdit: true,
                        onClicked: () {
                          showMaterialModalBottomSheet(
                              context: context,
                              builder: (context) => Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(16.0),
                                          topRight: Radius.circular(16.0)),
                                    ),
                                    child: Wrap(
                                      alignment: WrapAlignment.end,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.end,
                                      children: [
                                        ListTile(
                                          leading: Icon(Icons.camera),
                                          title: Text('Camera'),
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            controller.uploadImage(
                                                ImageSource.camera);
                                          },
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.image),
                                          title: Text('Gallery'),
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            controller.uploadImage(
                                                ImageSource.gallery);
                                          },
                                        ),
                                      ],
                                    ),
                                  ));
                        }),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                        label: 'Nome',
                        text: profile.name,
                        maxLength: 25,
                        onChanged: controller.setName),
                    //const SizedBox(height: 24),
                    TextFieldWidget(
                        label: 'Email',
                        text: profile.email,
                        fillColor: CustomColors.field,
                        enable: false,
                        onChanged: controller.setEmail),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                      label: 'CEP',
                      text: profile.postalCode ?? "",
                      onChanged: (v) {
                        controller.setCEP(v);
                        if (v.length >= 8) {
                          controller.searchCEP(v);
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                        label: 'Endereço',
                        fillColor: CustomColors.field,
                        enable: false,
                        text: profile.street ?? "",
                        onChanged: controller.setStreet),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                        label: 'Número',
                        text: profile.placeNumber ?? "",
                        onChanged: controller.setPlaceNumber),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                        label: 'Complemento',
                        text: profile.complement ?? "",
                        onChanged: controller.setComplement),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                        label: 'Estado',
                        fillColor: CustomColors.field,
                        enable: false,
                        text: profile.state,
                        onChanged: controller.setState),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                        label: 'Cidade',
                        fillColor: CustomColors.field,
                        enable: false,
                        text: profile.city,
                        onChanged: controller.setCity),
                    const SizedBox(height: 30),
                  ],
                );
              }),
        ));
  }
}
