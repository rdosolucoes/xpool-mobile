import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../../../shared/helpers/custom_colors.dart';
import '../../domain/entities/need_sup_entity.dart';
import '../widgets/profile_widget.dart';
import '../widgets/textfield_widget.dart';
import 'edit_profileSup_controller.dart';
import 'profileSup_controller.dart';

class EditProfileSupPage extends StatefulWidget {
  final String title;

  const EditProfileSupPage({Key? key, this.title = 'Meu Perfil'})
      : super(key: key);
  @override
  EditProfileSupPageState createState() => EditProfileSupPageState();
}

class EditProfileSupPageState extends State<EditProfileSupPage> {
  var controller = Modular.get<EditProfileSupController>();
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
                    var profileController = Modular.get<ProfileSupController>();
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
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
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
                    //const SizedBox(height: 14),
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
                        label: 'Bairro',
                        fillColor: CustomColors.field,
                        enable: false,
                        text: profile.district ?? "",
                        onChanged: controller.setDistrict),
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
                    SizedBox(height: 20),
                    Text(
                      "Serviços prestados",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                        padding: EdgeInsets.only(
                          top: 5,
                        ),
                        child: Wrap(
                            spacing: 4.0,
                            runSpacing: 2.0,
                            children: _buildChip(
                                controller.store.error?.message,
                                controller.store.state.needs))),
                    const SizedBox(height: 30),
                  ],
                );
              }),
        ));
  }

  List<Widget> _buildChip(String? messageError, List<NeedSupEntity> model) {
    var listItem = <FilterChip>[];

    listItem = model
        .map((e) => FilterChip(
              pressElevation: 5,
              shadowColor: CustomColors.darkBlue,
              backgroundColor: Colors.grey[100],
              label: Text(
                e.description,
              ),
              labelStyle: controller.store.existNeed(e.id)
                  ? TextStyle(color: Colors.white)
                  : TextStyle(color: Colors.black),
              selected: controller.store.existNeed(e.id),
              selectedColor: CustomColors.blueBar,
              showCheckmark: false,
              onSelected: (v) {
                if (v) {
                  controller.store.addNeed(e.id);
                } else {
                  controller.store.removeNeed(e.id);
                }
              },
            ))
        .toList();

    return listItem;
  }
}
