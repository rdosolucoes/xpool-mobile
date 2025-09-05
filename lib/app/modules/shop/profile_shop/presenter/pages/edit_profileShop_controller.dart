import 'package:asuka/asuka.dart' as asuka;
import 'package:azblob/azblob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:search_cep/search_cep.dart';
import '../../../../../../shared/auth/local_storage/interfaces/auth_repository_interface.dart';
import '../../../../../../shared/auth/stores/auth_store.dart';
import '../../../../../../shared/components/loading_progress_indicator/loading_progress_indicator_widget.dart';
import '../../../../../../shared/helpers/consts.dart';
import '../../domain/entities/profile_shop_entity.dart';
import '../../domain/usecases/post_profile_shop.dart';
import '../stores/profileShop_store.dart';

class EditProfileShopController {
  final ProfileShopStore store;
  final PostProfileShop _postProfile;
  final AuthStore _authStore;
  final IAuthLocalStorage _localStorage;

  EditProfileShopController(
      this.store, this._postProfile, this._authStore, this._localStorage);

  Future<void> uploadImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(
        source: imageSource, maxWidth: 600, maxHeight: 600, imageQuality: 60);

    if (pickedFile != null) {
      store.setImageLocal(pickedFile);
    }
  }

  Future<String?> uploadImageToAzure(XFile? pickedFile) async {
    try {
      //final pickedFile = await ImagePicker().pickImage(source: imageSource);

      if (pickedFile != null) {
        store.setImageLocal(pickedFile);

        var fileName = pickedFile.path.split('/').last;
        // read file as Uint8List
        var content = await pickedFile.readAsBytes();
        var storage = AzureStorage.parse(azureStorage);

        // get the mine type of the file
        var contentType = lookupMimeType(fileName);

        await storage.putBlob('/$containerImage/$fileName',
            bodyBytes: content,
            contentType: contentType,
            type: BlobType.BlockBlob);

        print("Success upload Image");

        var filePath = "$baseUrlStorage/$containerImage/$fileName";
        store.setImage(filePath);
        _authStore.setImage(filePath);

        return filePath;
      }
    } on AzureStorageException catch (ex) {
      print(ex.message);
      return "$baseUrlStorage/images/noimage_shop.png";
    }
    return null;
  }

  Future<void> save(ProfileShopEntity model) async {
    var overlay = OverlayEntry(
      builder: (context) {
        return LoadingProgressIndicatorWidget(
          isCustom: true,
        );
      },
    );

    try {
      asuka.addOverlay(overlay);
      await Future.delayed(Duration(seconds: 2));

      if (model.imageLocal != null) {
        await uploadImageToAzure(model.imageLocal)
            .then((value) => model.image = value ?? "");
      }

      var result = await _postProfile(model);

      result.fold((l) {
        asuka.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(l.message ?? ""),
        ));
      }, (r) {
        _authStore.setName(store.state.name);
        _localStorage.update(_authStore.state);
        Modular.to.pop();
      });
    } finally {
      overlay.remove();
    }
  }

  Future<void> searchCEP(String v) async {
    final viaCepSearchCep = ViaCepSearchCep();
    final infoCepJSON = await viaCepSearchCep.searchInfoByCep(cep: v);
    String? street = "";
    String? state = "";
    String? city = "";

    infoCepJSON.fold((l) => null, (r) {
      street = r.logradouro;
      city = r.localidade;
      state = r.uf;
    });

    print(infoCepJSON);

    setStreet(street ?? "");
    setCity(city ?? "");
    setState(state ?? "");
  }

  void setCEP(String v) => store.setPostalCode(v);
  void setStreet(String v) => store.setStreet(v);
  void setState(String v) => store.setState(v);
  void setCity(String v) => store.setCity(v);
  void setName(String v) => store.setName(v);
  void setEmail(String v) => store.setEmail(v);
  void setPlaceNumber(String v) => store.setPlaceNumber(v);
  void setComplement(String v) => store.setComplement(v);
}
