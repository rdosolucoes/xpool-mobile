import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../../../../shared/components/loading_shimmer/shimmer_widget.dart';
import '../../domain/entities/dispute_entity.dart';
import 'components/dispute_form_widget.dart';
import 'dispute_controller.dart';

class DisputePage extends StatefulWidget {
  final String title;
  final List<int> reference;

  const DisputePage(this.reference, {Key? key, this.title = 'Contestação'})
      : super(key: key);
  @override
  DisputePageState createState() => DisputePageState();
}

class DisputePageState extends State<DisputePage> {
  var controller = Modular.get<DisputeController>();
  @override
  void initState() {
    controller.getDispute(widget.reference[1], widget.reference[0]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: TripleBuilder(
        store: controller.store,
        builder: (context, triple) {
          if (triple.isLoading || !controller.hasValue()) {
            return Center(child: ShimmerWidget());
          } else {
            return buildForm(
                controller.store.error?.message, controller.store.state);
          }
        },
      ),
    );
  }

  Widget buildForm(String? messageError, DisputeEntity model) {
    return Container(
        padding: EdgeInsets.all(10),
        child: DisputeFormWidget(
          disputeId: model.id,
          supplierName: model.supplierName,
          customerName: model.customerName,
          imageSup: model.imageSup,
          dateContest: model.dateContest,
          dateReference: model.dateReference,
          needDescription: model.needDescription,
          messageContest: model.messageContest,
          pressApprove: () => controller.approveDispute(model.id),
          pressDisapprove: controller.disapproveDispute,
        ));
  }
}
