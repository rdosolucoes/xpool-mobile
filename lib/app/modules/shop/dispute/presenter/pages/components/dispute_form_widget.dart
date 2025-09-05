import 'package:flutter/material.dart';

import '../../../../../../../shared/components/circular_cached_image/circular_cached_image_widget.dart';
import '../../../../../../../shared/components/default_flat_button/default_flat_button_widget.dart';
import '../../../../../../../shared/helpers/custom_colors.dart';

class DisputeFormWidget extends StatelessWidget {
  final int disputeId;
  final String supplierName;
  final String needDescription;
  final String customerName;
  final String imageSup;
  final String dateReference;
  final String messageContest;
  final String dateContest;
  final VoidCallback pressApprove;
  final Function(int referenceId, String message) pressDisapprove;

  const DisputeFormWidget(
      {Key? key,
      this.disputeId = 0,
      this.supplierName = "",
      this.needDescription = "",
      this.customerName = "",
      this.imageSup = "",
      this.dateReference = "",
      this.messageContest = "",
      this.dateContest = "",
      required this.pressApprove,
      required this.pressDisapprove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController();

    textController.text = messageContest;

    void _showDisapproveDialog() {
      var fieldController = TextEditingController();
      final _formKey = GlobalKey<FormState>();

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              contentPadding: EdgeInsets.only(top: 10.0),
              content: SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "Reprovar Contestação",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Divider(
                        color: Colors.grey,
                        height: 4.0,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 30.0, right: 30.0),
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              controller: fieldController,
                              decoration: InputDecoration(
                                hintText: "Informe o Motivo",
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                return value!.isNotEmpty
                                    ? null
                                    : "*Obrigatório Informar o Motivo";
                              },
                              maxLines: 8,
                            ),
                          )),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            pressDisapprove(disputeId, fieldController.text);
                            Navigator.of(context).pop();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                          decoration: BoxDecoration(
                            color: CustomColors.primary,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(32.0),
                                bottomRight: Radius.circular(32.0)),
                          ),
                          child: Text(
                            "Confirmar",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    }

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircularCachedNetworkImage(
                  imageURL: imageSup,
                  size: 50,
                  borderColor: Colors.white,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      supplierName,
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      needDescription,
                      style: TextStyle(
                          color: CustomColors.graniteGray, fontSize: 10),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      "Cliente:$customerName",
                      style: TextStyle(color: Colors.grey, fontSize: 9),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      dateReference,
                      style: TextStyle(color: Colors.grey, fontSize: 9),
                      textAlign: TextAlign.start,
                    )
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Data/Hora Contestação:",
                        style: TextStyle(fontSize: 9),
                        textAlign: TextAlign.end,
                      ),
                      Text(
                        dateContest,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 9,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: textController,
              readOnly: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              )),
              maxLines: 6,
              style: TextStyle(color: CustomColors.graniteGray),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DefaultFlatButtonWidget(
                    label: "Aprovar e Estornar",
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Confirmação'),
                              content: const Text(
                                  'Você tem certeza que deseja aprovar esta contestação e estornar o valor recebido ?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      pressApprove();
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
                    }),
                DefaultFlatButtonWidget(
                    label: "Reprovar", onPressed: _showDisapproveDialog)
              ],
            )
          ],
        ),
      ),
    );
  }
}
