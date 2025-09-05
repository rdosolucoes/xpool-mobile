import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CreditCardTileWidget extends StatelessWidget {
  final String creditCardId;
  final String name;
  final String number;
  final String brand;
  final bool isDefault;
  final Function(String) pressDefault;
  final Function(String) pressDelete;

  CreditCardTileWidget(
      {Key? key,
      required this.creditCardId,
      required this.name,
      required this.number,
      required this.brand,
      required this.isDefault,
      required this.pressDefault,
      required this.pressDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
        // Specify a key if the Slidable is dismissible.
        key: ValueKey(0),

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
                pressDelete(creditCardId);
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Excluir',
            ),
            Visibility(
              visible: !isDefault,
              child: SlidableAction(
                onPressed: (context) {
                  pressDefault(creditCardId);
                },
                backgroundColor: Colors.amber,
                foregroundColor: Colors.white,
                icon: Icons.assistant_photo_outlined,
                label: 'Padrão',
              ),
            ),
          ],
        ),
        child: ListTile(
            contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            leading: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 32,
                maxHeight: 32,
              ),
              child: Image.asset(
                brand,
                fit: BoxFit.fill,
                alignment: Alignment.bottomRight,
              ),
            ),
            title: Text(
              isDefault ? "$name    [Padrão]" : "$name",
              style: TextStyle(fontSize: 16),
            ),
            trailing: Text("***$number", style: TextStyle(fontSize: 18))));
  }
}
