import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../../../../../shared/components/default_flat_button/default_flat_button_widget.dart';
import '../../../../../../../shared/helpers/errors.dart';
import '../../../../../../../shared/helpers/utils.dart';
import '../../../domain/entities/sup_entity.dart';
import '../../stores/need_store.dart';
import '../../view_models/need_view_model.dart';
import '../components/sup_tile_needs_widget.dart';
import 'select_needs_sup_controller.dart';

class SelectNeedsSupPage extends StatefulWidget {
  final String title;
  final SupEntity model;

  const SelectNeedsSupPage({Key? key, this.title = '', required this.model})
      : super(key: key);
  @override
  SelectNeedsSupPageState createState() => SelectNeedsSupPageState();
}

class SelectNeedsSupPageState extends State<SelectNeedsSupPage> {
  var controller = Modular.get<SelectNeedsSupController>();
  @override
  void initState() {
    controller.getNeeds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
              alignment: Alignment.bottomLeft,
              margin: EdgeInsets.all(10),
              child: Text(
                "Informe os Serviços Prestados",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              height: 30),
          Expanded(
            child: ScopedBuilder<NeedStore, Failure, NeedVM>(
              store: controller.store,
              onLoading: (_) => Center(child: CircularProgressIndicator()),
              onError: (_, error) => Utils.buildError(
                  'Erro ao realizar busca: ${error?.message ?? ''}',
                  controller.getNeeds()),
              onState: (_, state) {
                if (state.needs.length == 0) {
                  return Text('Nenhum serviço encontrado');
                }

                return ListView.builder(
                  itemCount: state.listNeeds.length,
                  itemBuilder: (_, index) {
                    var supplier = state.listNeeds[index];

                    return SupTileNeedsWidget(
                      icon: supplier.image!,
                      description: supplier.description,
                      value: controller.store.existNeed(supplier.id),
                      onChanged: (v) {
                        if (v!) {
                          controller.store.addNeed(supplier.id);
                        } else {
                          controller.store.removeNeed(supplier.id);
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
          Row(children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10),
                // padding: const EdgeInsets.all(5.0),
                child: DefaultFlatButtonWidget(
                    label: "CONFIRMAR",
                    onPressed: () {
                      controller.confirm();
                    }),
              ),
            )
          ])
        ]));
  }
}
