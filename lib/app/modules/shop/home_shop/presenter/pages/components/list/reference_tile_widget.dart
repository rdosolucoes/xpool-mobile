import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../../../../../shared/helpers/app_assets.dart';
import '../../../../../../../../shared/helpers/custom_colors.dart';
import '../../../../../partnership_shop/domain/entities/supplier_entity.dart';
import 'reference_detail_widget%20.dart';
import 'reference_icons_widget.dart';

class ReferenceTile extends StatelessWidget {
  final String dateHour;
  final String need;
  final String customerName;
  final String iconNeed;
  final String localMainText;
  final String localSecondaryText;
  final String totalReference;
  final String totalAccept;
  final String totalReject;
  final String totalContest;
  final int status;
  final int referenceId;
  final VoidCallback deleteReference;
  final List<SupplierEntity> suppliers;
  final String employee;

  ReferenceTile(
      {Key? key,
      this.dateHour = '',
      this.need = '',
      this.customerName = '',
      this.iconNeed = '',
      this.localMainText = '',
      this.localSecondaryText = '',
      this.totalReference = '0',
      this.totalAccept = '0',
      this.totalReject = '0',
      this.totalContest = '0',
      this.status = 0,
      this.referenceId = 0,
      this.employee = "",
      required this.deleteReference,
      this.suppliers = const <SupplierEntity>[]})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    void _showDialog(String title) {
      showDialog(
        context: context,
        builder: (context) {
          // retorna um objeto do tipo Dialog
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            content: Container(
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey[200],
                    ),
                    shrinkWrap: true,
                    padding: EdgeInsets.all(0),
                    itemCount: suppliers.length,
                    itemBuilder: (_, index) {
                      var supplier = suppliers[index];

                      return ReferenceDetail(
                          supplierName: supplier.name,
                          status: supplier.status,
                          image: supplier.photo,
                          referenceId: referenceId,
                          supplierId: supplier.id);
                    },
                  ),
                  Visibility(
                      child: Divider(height: 10), visible: employee != ""),
                  Visibility(
                    visible: employee != "",
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 5),
                      child: Text(
                        "Criado por " "$employee",
                        style: TextStyle(
                            fontSize: 12,
                            color: CustomColors.primary,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            ),
            /* actions: <Widget>[
              // define os botões na base do dialogo
              TextButton(
                child: Text("Fechar",
                    style: TextStyle(color: CustomColors.primary)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],*/
          );
        },
      );
    }

    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: ValueKey(0),
      enabled: status == 0,
      // The start action pane is the one at the left or the top side.
      endActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: StretchMotion(),

        // A pane can dismiss the Slidable.
        dismissible: null,

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (context) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Confirmação'),
                      content: const Text(
                          'Você tem certeza que deseja excluir esta indicação ?'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              deleteReference();
                              Navigator.of(context).pop();
                            },
                            child: const Text('Sim')),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Não'))
                      ],
                    );
                  });
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Excluir',
          ),
        ],
      ),
      child: ListTile(
          onTap: () {
            _showDialog("Detalhes");
          },
          leading: CircleAvatar(
            backgroundImage: AssetImage("${AppAssets.images}$iconNeed"),
            radius: 30,
          ),
          //dense: true,
          title: Text(need),
          tileColor: CustomColors.darkBlue,
          trailing: _buildStatus(),
          minVerticalPadding: 2,
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 2,
              ),
              Text(
                "$customerName" " - " "$dateHour",
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.pin_drop,
                    color: CustomColors.flamingo,
                    size: 20,
                  ),
                  SizedBox(width: 2),
                  Flexible(
                    child: Text(
                      "$localMainText" " - $localSecondaryText",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ReferenceIcons(
                      image: AppAssets.supplier, value: totalReference),
                  ReferenceIcons(image: AppAssets.confirm, value: totalAccept),
                  ReferenceIcons(image: AppAssets.reject, value: totalReject),
                  Visibility(
                    visible: int.parse(totalContest) > 0,
                    child: ReferenceIcons(
                        image: AppAssets.exclamation, value: totalContest),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  Widget _buildStatus() {
    if (status == 0) {
      return Icon(Icons.radio_button_checked, color: Colors.green);
    } else if (status == 1) {
      return Icon(Icons.check_circle, color: Colors.blue);
    } else if (status == 3) {
      return Icon(Icons.radio_button_checked, color: Colors.red);
    } else {
      return Icon(Icons.schedule, color: Colors.brown);
    }
  }

  void onDeletePressed(BuildContext context) async {
    if (suppliers.any((x) => x.status > 0)) {
      asuka.showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text("Indicação já em andamento não pode ser excluída."),
      ));
    } else {
      deleteReference;
    }
  }
}
