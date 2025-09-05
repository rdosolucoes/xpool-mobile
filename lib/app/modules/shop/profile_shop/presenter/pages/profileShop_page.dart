import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../../../../shared/helpers/custom_colors.dart';
import '../../domain/entities/profile_shop_entity.dart';
import '../widgets/numbers_widget.dart';
import '../widgets/profile_widget.dart';
import 'profileShop_controller.dart';

class ProfileShopPage extends StatefulWidget {
  final String title;
  const ProfileShopPage({Key? key, this.title = 'Meu Perfil'})
      : super(key: key);
  @override
  ProfileShopPageState createState() => ProfileShopPageState();
}

class ProfileShopPageState extends State<ProfileShopPage> {
  var controller = Modular.get<ProfileShopController>();
  @override
  void initState() {
    controller.getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Meu Perfil",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: BackButton(color: Colors.white),
          backgroundColor: CustomColors.primary,
          elevation: 0,
        ),
        body: TripleBuilder(
          store: controller.store,
          builder: (context, triple) {
            if (triple.isLoading || controller.loading) {
              return Center(child: CircularProgressIndicator());
            }
            return buildForm(
                controller.store.error?.message, controller.store.state);
          },
        ));
  }

  Widget buildForm(String? messageError, ProfileShopEntity model) {
    return ListView(
      padding: EdgeInsets.only(top: 20),
      physics: BouncingScrollPhysics(),
      children: [
        ProfileWidget(
          imagePath: model.image,
          onClicked: () {
            controller.editProfile();
          },
        ),
        const SizedBox(height: 24),
        Column(
          children: [
            Text(
              model.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 4),
            Text(
              model.cpf,
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
        const SizedBox(height: 20),
        NumbersWidget(
            totalAprove: model.totalAccept,
            totalReference: model.totalReference,
            totalReprove: model.totalReject),
      ],
    );
  }
}
