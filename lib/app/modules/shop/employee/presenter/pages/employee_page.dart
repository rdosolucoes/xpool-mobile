import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../shared/components/default_flat_button/default_flat_button_widget.dart';
import '../../../../../../shared/components/loading_shimmer/shimmer_widget.dart';
import '../../../../../../shared/helpers/app_assets.dart';
import '../../../../../../shared/helpers/custom_colors.dart';
import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/helpers/utils.dart';
import '../stores/employee_store.dart';
import '../viewModel/EmployeeVM.dart';
import 'components/employee_tile.dart';
import 'employee_controller.dart';

class EmployeePage extends StatefulWidget {
  final String title;
  const EmployeePage({Key? key, this.title = 'Funcionários'}) : super(key: key);
  @override
  EmployeePageState createState() => EmployeePageState();
}

class EmployeePageState extends State<EmployeePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var controller = Modular.get<EmployeeController>();

  Future<void> onPressCreate() async {
    controller.clearFields();
    openFormEdit();
  }

  Future<void> onPressEdit(
      int id, String name, String login, String password) async {
    controller.setId(id);
    controller.setName(name);
    controller.setLogin(login);
    controller.setPassword(password);
    openFormEdit();
  }

  Future<void> onPressPsw(
      int id, String name, String login, String password) async {
    controller.setId(id);
    controller.setName(name);
    controller.setLogin(login);

    openFormPsw();
  }

  Future<void> onPressDelete(int id) async {
    controller.deleteEmployee(id);
  }

  Future<void> openFormEdit() async {
    var _isInsert = controller.store.state.id == 0;
    showModalBottomSheet(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        isScrollControlled: true,
        builder: (context) {
          return SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                        20.0, 20.0, 20.0, 0.0), // content padding
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                            child: Text(
                              "Dados do Funcionário",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ),
                          TextFormField(
                            initialValue: controller.store.state.name,
                            onChanged: controller.setName,
                            validator: (value) {
                              return value!.isNotEmpty
                                  ? null
                                  : "Informe o Nome";
                            },
                            decoration: InputDecoration(
                              labelText: 'Nome',
                            ),
                          ),
                          TextFormField(
                            initialValue: controller.store.state.login,
                            onChanged: controller.setLogin,
                            enabled: _isInsert,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CpfInputFormatter(),
                            ],
                            validator: (value) {
                              return value!.isNotEmpty ? null : "Informe CPF";
                            },
                            //keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              labelText: 'CPF',
                            ),
                          ),
                          Visibility(
                            visible: _isInsert,
                            child: TextFormField(
                              initialValue: controller.store.state.password,
                              onChanged: controller.setPassword,
                              validator: (value) {
                                return value!.isNotEmpty
                                    ? null
                                    : "Informe a Senha";
                              },
                              //keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                labelText: 'Senha',
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 30, bottom: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                DefaultFlatButtonWidget(
                                    label: "Confirmar",
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        FocusScope.of(context).unfocus();
                                        controller.saveEmployee();
                                      }
                                    }) //,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ), // From with TextField inside
                  )));
        },
        context: context);
  }

  Future<void> openFormPsw() async {
    showModalBottomSheet(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        isScrollControlled: true,
        builder: (context) {
          return SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                        20.0, 20.0, 20.0, 0.0), // content padding
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                            child: Text(
                              "Alteração de Senha",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ),
                          TextFormField(
                            onChanged: controller.setPassword,
                            validator: (value) {
                              return value!.isNotEmpty
                                  ? null
                                  : "Informe a Senha";
                            },
                            //keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              labelText: 'Nova Senha',
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 30, bottom: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                DefaultFlatButtonWidget(
                                    label: "Confirmar",
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        FocusScope.of(context).unfocus();
                                        controller.saveEmployee();
                                      }
                                    }) //,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ), // From with TextField inside
                  )));
        },
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onPressCreate,
        child: const FaIcon(FontAwesomeIcons.plus, color: Colors.white),
        backgroundColor: CustomColors.primary,
      ),
      body: ScopedBuilder<EmployeeStore, Failure, EmployeeVM>(
        store: controller.store,
        onLoading: (_) => Center(child: ShimmerWidget()),
        onError: (_, error) => Utils.buildError(
            'Erro ao realizar busca: ${error?.message ?? ''}',
            controller.getEmployees()),
        onState: (_, state) {
          if (state.employees.length == 0) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //SizedBox(height: 60),
                  Image.asset(
                    AppAssets.noresult,
                    scale: 7,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'Nenhum Funcionário Encontrado',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Inclua novos funcionários.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12,
                        color: CustomColors.darkBlue,
                        fontWeight: FontWeight.w600),
                  ),
                  TextButton(
                      onPressed: controller.getEmployees,
                      child: Icon(
                        Icons.update,
                        size: 30,
                      ))
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: controller.getEmployees,
            child: ListView.builder(
              padding: EdgeInsets.all(0),
              itemCount: state.employees.length,
              itemBuilder: (_, index) {
                var employee = state.employees[index];

                return EmployeeTile(
                  id: employee.id,
                  name: employee.name,
                  login: employee.login,
                  password: employee.password,
                  onPress: onPressEdit,
                  onPressDelete: onPressDelete,
                  onPressPsw: onPressPsw,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
