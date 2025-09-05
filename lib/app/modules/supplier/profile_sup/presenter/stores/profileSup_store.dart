import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx_triple/mobx_triple.dart';

import '../../../../../../shared/helpers/either_adapter/dartz_either_adapter.dart';
import '../../../../../../shared/helpers/errors.dart';
import '../../domain/entities/need_sup_entity.dart';
import '../../domain/entities/profile_sup_entity.dart';

class ProfileSupStore extends MobXStore<Failure, ProfileSupEntity> {
  ProfileSupStore()
      : super(ProfileSupEntity(selectedNeeds: [1, 2, 3], needs: []));

  Future<void> setProfile(Either<Failure, ProfileSupEntity> value) async {
    setLoading(true);
    await executeEither(() async => DartzEitherAdapter(value),
        delay: Duration(milliseconds: 500));
    setLoading(false);
  }

  void setErrorMsg(String? v) => update(state.copyWith(messageError: v));

  void setName(String v) {
    var newState = state.copyWith(name: v);
    update(newState);
  }

  void setPhone(String v) {
    var newState = state.copyWith(phone: v);
    update(newState);
  }

  void setEmail(String v) {
    var newState = state.copyWith(email: v);
    update(newState);
  }

  void setImage(String v) {
    var newState = state.copyWith(image: v);
    update(newState);
  }

  void setImageLocal(XFile? v) {
    var newState = state.copyWith(imageLocal: v);
    update(newState);
  }

  void setPostalCode(String? v) {
    var newState = state.copyWith(postalCode: v);
    update(newState);
  }

  void setStreet(String? v) {
    var newState = state.copyWith(street: v);
    update(newState);
  }

  void setDistrict(String? v) {
    var newState = state.copyWith(district: v);
    update(newState);
  }

  void setState(String? v) {
    var newState = state.copyWith(state: v);
    update(newState);
  }

  void setCity(String? v) {
    var newState = state.copyWith(city: v);
    update(newState);
  }

  void setPlaceNumber(String? v) {
    var newState = state.copyWith(placeNumber: v);
    update(newState);
  }

  void setComplement(String? v) {
    var newState = state.copyWith(complement: v);
    update(newState);
  }

  void setTotalReference(int v) {
    var newState = state.copyWith(totalReference: v);
    update(newState);
  }

  void setTotalAprove(int v) {
    var newState = state.copyWith(totalAccept: v);
    update(newState);
  }

  void setTotalReprove(int v) {
    var newState = state.copyWith(totalReject: v);
    update(newState);
  }

  void setNeeds(Either<Failure, List<NeedSupEntity>> value) async {
    var result = value;

    result.fold(
      setError,
      (r) {
        var newState = state.copyWith(needs: r);
        update(newState);
      },
    );
  }

  void setSelectedNeeds(List<int> v) async {
    var newState = state.copyWith(selectedNeeds: v);
    update(newState);
  }

  Future<void> clear() async {
    setError(DefaultFailure(message: ""));
    update(ProfileSupEntity(selectedNeeds: [], needs: []));
  }

  void addNeed(int id) {
    state.selectedNeeds.add(id);
    var newState = state.copyWith(selectedNeeds: state.selectedNeeds);
    execute(() async => newState);
  }

  void removeNeed(int id) {
    state.selectedNeeds.removeWhere((value) => value == id);
    var newState = state.copyWith(selectedNeeds: state.selectedNeeds);
    execute(() async => newState);
  }

  bool existNeed(int id) {
    var index = state.selectedNeeds.indexWhere((value) => value == id);
    return (index != -1);
  }
}
