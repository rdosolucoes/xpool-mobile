import '../../../../../../shared/needs/domain/entity/need_entity.dart';

class NeedVM {
  final List<NeedEntity> needs;
  List<int> addedNeeds;
  List<NeedEntity> get listNeeds => needs.toList();

  NeedVM({
    this.needs = const <NeedEntity>[],
    this.addedNeeds = const <int>[],
  });

  NeedVM copyWith({
    List<NeedEntity>? needs,
    required List<int> addedNeeds,
  }) {
    return NeedVM(needs: needs ?? this.needs, addedNeeds: addedNeeds);
  }
}
