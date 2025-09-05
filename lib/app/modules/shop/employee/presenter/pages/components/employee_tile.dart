import 'package:flutter/material.dart';
import '../../../../../../../shared/helpers/custom_colors.dart';

class EmployeeTile extends StatelessWidget {
  final int id;
  final String name;
  final String login;
  final String password;
  final Function(int id, String name, String login, String password) onPress;
  final Function(int id, String name, String login, String password) onPressPsw;
  final Function(int id) onPressDelete;

  EmployeeTile({
    Key? key,
    required this.id,
    required this.name,
    required this.login,
    required this.password,
    required this.onPress,
    required this.onPressPsw,
    required this.onPressDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: CustomColors.primary,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
            leading: Icon(
              Icons.person_pin,
              size: 60,
              color: CustomColors.primary,
            ),
            contentPadding: EdgeInsets.fromLTRB(10, 0, 15, 0),
            onTap: () => onPress(id, name, login, password),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                    onTap: () => onPressPsw(id, name, login, password),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Icon(
                        Icons.lock,
                        size: 30,
                      ),
                    )),
                InkWell(
                    onTap: () => showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            title: const Text('Confirmação'),
                            content: const Text(
                                'Você tem certeza que deseja excluir este funcionário ?'),
                            actions: [
                              // The "Yes" button
                              TextButton(
                                  onPressed: () {
                                    // Remove the box
                                    onPressDelete(id);

                                    // Close the dialog
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Sim')),
                              TextButton(
                                  onPressed: () {
                                    // Close the dialog
                                    Navigator.of(ctx).pop();
                                  },
                                  child: const Text('Não'))
                            ],
                          );
                        }),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Icon(
                        Icons.delete_forever,
                        size: 30,
                        //color: Colors.red,
                      ),
                    )),
              ],
            ),
            title: Text(name),
            minVerticalPadding: 2,
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 2,
                ),
                Text(
                  login,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            )));
  }
}
