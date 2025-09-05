import '../../../../../../shared/needs/domain/entity/need_entity.dart';

class NeedVM {
  final List<NeedEntity> needs;
  List<NeedEntity> get listNeeds => needs.toList();

  NeedVM({
    this.needs = const <NeedEntity>[],
  });

  NeedVM copyWith({List<NeedEntity>? needs}) {
    return NeedVM(needs: needs ?? this.needs);
  }
}
