import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../../../../shared/components/default_dropdown_field/default_dropdown_field_widget.dart';
import '../../../../../../../shared/components/default_flat_button/default_flat_button_widget.dart';
import '../../../../../../../shared/components/default_text_field/default_text_field_widget.dart';
import '../../../../../../../shared/helpers/consts.dart';
import '../../../../../../../shared/models/dropdown_model.dart';
import '../../widgets/profile_widget.dart';

class FormProfileShopWidget extends StatelessWidget {
  final String title;
  final String image;
  final String imageLocal;

  final Function(String) nameChanged;
  final Function(String) cepChanged;
  final Function(String) streetChanged;
  final Function(String) emailChanged;
  final Function(DropdownModel?)? stateChanged;
  final Function(DropdownModel?)? cityChanged;
  final DropdownModel? cityValue;
  final Future<List<DropdownModel>> Function(String?)? getCities;
  final String? errorMsg;
  final VoidCallback? confirmPressed;

  const FormProfileShopWidget(
      {Key? key,
      this.title = "FormProfileShopWidget",
      this.image = "",
      this.imageLocal = "",
      required this.nameChanged,
      required this.cepChanged,
      required this.streetChanged,
      required this.emailChanged,
      this.stateChanged,
      this.cityChanged,
      this.cityValue,
      this.getCities,
      this.errorMsg,
      this.confirmPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ProfileWidget(
                    imagePath: image,
                    imageLocal: imageLocal,
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
                                  crossAxisAlignment: WrapCrossAlignment.end,
                                  children: [
                                    ListTile(
                                      leading: Icon(Icons.camera),
                                      title: Text('Camera'),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        // controller
                                        //   .uploadImage(ImageSource.camera);
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.image),
                                      title: Text('Gallery'),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        //controller
                                        //  .uploadImage(ImageSource.gallery);
                                      },
                                    ),
                                  ],
                                ),
                              ));
                    }),

                DefaultTextFieldWidget(
                    labelText: 'Nome',
                    fontColor: Colors.black.withOpacity(0.8),
                    onChanged: nameChanged,
                    keyboardType: TextInputType.name,
                    maxLenght: 30,
                    errorMessage: errorMsg),
                //SizedBox(height: 20),
                DefaultTextFieldWidget(
                  labelText: 'Email',
                  fontColor: Colors.black.withOpacity(0.8),
                  onChanged: emailChanged,
                  keyboardType: TextInputType.phone,
                  errorMessage: errorMsg,
                  inputFormatter: [
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter(),
                  ],
                ),

                SizedBox(height: 15),
                DefaultTextFieldWidget(
                  labelText: 'Cep',
                  fontColor: Colors.black.withOpacity(0.8),
                  onChanged: cepChanged,
                  keyboardType: TextInputType.number,
                  errorMessage: errorMsg,
                ),
                SizedBox(height: 15),
                DefaultTextFieldWidget(
                  labelText: 'Endereço',
                  fontColor: Colors.black.withOpacity(0.8),
                  onChanged: streetChanged,
                  keyboardType: TextInputType.streetAddress,
                  errorMessage: errorMsg,
                ),
                SizedBox(height: 15),
                DefaultDropDownFieldWidget(
                    labelText: 'Estado',
                    fontColor: Colors.black.withOpacity(0.8),
                    items: statesList,
                    onChanged: stateChanged,
                    errorMessage: errorMsg),
                SizedBox(height: 15),
                DefaultDropDownFieldWidget(
                    labelText: 'Cidade',
                    fontColor: Colors.black.withOpacity(0.8),
                    showSearchBox: true,
                    getData: getCities,
                    onChanged: cityChanged,
                    selectedItem: cityValue,
                    errorMessage: errorMsg),
                SizedBox(height: 15),
                Visibility(
                  visible: (errorMsg?.length ?? 0) != 0,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: size.height * 0.3,
                      ),
                      child: Text(
                        errorMsg ?? '',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: DefaultFlatButtonWidget(
                          label: "CONFIRMAR", onPressed: () {}), //loginPressed,
                    ),
                  ],
                ),
              ]),
        ));
  }
}
