import 'package:dartz/dartz.dart';
import 'package:mobx_triple/mobx_triple.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../domain/entities/employee_entity.dart';
import '../viewModel/EmployeeVM.dart';

class EmployeeStore extends MobXStore<Failure, EmployeeVM> {
  EmployeeStore() : super(EmployeeVM());

  void setEmployees(Future<Either<Failure, List<EmployeeEntity>>> value) async {
    setLoading(true);
    var result = await value;

    result.fold(
      setError,
      (r) {
        var newState = state.copyWith(employees: r);
        setLoading(false);
        update(newState);
      },
    );
    setLoading(false);
  }

  void setId(int v) {
    var newState = state.copyWith(id: v);
    update(newState);
  }

  void setName(String v) {
    var newState = state.copyWith(name: v);
    update(newState);
  }

  void setLogin(String v) {
    var newState = state.copyWith(login: v);
    update(newState);
  }

  void setPassword(String v) {
    var newState = state.copyWith(password: v);
    update(newState);
  }

  Future<void> clear() async {
    setError(DefaultFailure(message: ""));
    update(EmployeeVM(employees: state.employees));
  }
}
