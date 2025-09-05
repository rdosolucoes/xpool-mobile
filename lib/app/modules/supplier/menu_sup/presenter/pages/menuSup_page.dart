import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:package_info/package_info.dart';

import '../../../../../../shared/components/menu_item/menu_item_widget.dart';
import '../../../../../../shared/helpers/custom_colors.dart';
import '../../../start_sup/presenter/pages/startSup_controller.dart';
import 'menuSup_controller.dart';

class MenuSupPage extends StatefulWidget {
  final String title;
  const MenuSupPage({Key? key, this.title = 'MenuSupPage'}) : super(key: key);

  @override
  MenuSupPageState createState() => MenuSupPageState();
}

class MenuSupPageState extends State<MenuSupPage> {
  var controller = Modular.get<MenuSupController>();
  @override
  void initState() {
    controller.getLogin();
    super.initState();
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            // define os botões na base do dialogo
            TextButton(
              child:
                  Text("Fechar", style: TextStyle(color: CustomColors.primary)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _confirmMessage() {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Exclusão Solicitada'),
            content: const Text(
                'Sua solicitação foi enviada para o Suporte e em até 24 horas sua conta será excluída e você será notificado por email.'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    controller.cancelAccount();
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('OK')),
            ],
          );
        });
  }

  _adviceMessage() {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Solicitação de Exclusão'),
            content: const Text(
                'Sua solicitação já foi enviada. Em até 24 horas sua conta será excluída.'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    controller.cancelAccount();
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('OK')),
            ],
          );
        });
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
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 12,
            right: 12,
            top: 40,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TripleBuilder(
                        store: controller.authStore,
                        builder: (context, triple) {
                          return Text(controller.authStore.state.name ?? "",
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: CustomColors.primary));
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    Text(controller.msgWelcome,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: CustomColors.darkBlue))
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MenuItemWidget(
                onPressed: () => Modular.to.pushNamed('/profileSup'),
                icon: Icons.person,
                caption: "Perfil",
              ),
              MenuItemWidget(
                onPressed: () => Modular.to.pushNamed('/creditCard'),
                icon: Icons.credit_card,
                caption: "Cartões de Crédito",
              ),
              MenuItemWidget(
                onPressed: () async {
                  var packageInfo = await PackageInfo.fromPlatform();
                  var appName = packageInfo.appName;
                  var version = packageInfo.version;
                  var buildNumber = packageInfo.buildNumber;
                  _showDialog("Sobre o $appName",
                      "Versão: $version\nNúmero da compilação: $buildNumber");
                },
                icon: Icons.info,
                caption: "Sobre o App",
              ),
              MenuItemWidget(
                onPressed: () =>
                    _showDialog("Termos de uso", "Menu em construção"),
                icon: Icons.file_copy,
                caption: "Termos de Uso",
              ),
              MenuItemWidget(
                onPressed: () => _showDialog(
                    "Políticas de privacidade", "Menu em construção"),
                icon: Icons.lock,
                caption: "Política de Privacidade",
              ),
              MenuItemWidget(
                onPressed: () {
                  if (controller.isPendingDelete()) {
                    _adviceMessage();
                  } else {
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            title: const Text('Confirmação'),
                            content: const Text(
                                'Que pena você querer nos deixar, sua conta será deletada e não será possível recupera-la novamente.\nDeseja continuar ?'),
                            actions: [
                              // The "Yes" button
                              TextButton(
                                  onPressed: () {
                                    controller.cancelAccount();
                                    Navigator.of(ctx).pop();
                                    _confirmMessage();
                                  },
                                  child: const Text('Sim')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: const Text('Não'))
                            ],
                          );
                        });
                  }
                },
                icon: Icons.delete_forever,
                caption: "Solicitar Exclusão da Conta",
              ),
              MenuItemWidget(
                onPressed: () => controller.logout(),
                icon: Icons.door_front_door,
                caption: "Sair",
              ),
            ],
          ),
        ),
      )),
    );
  }
}
