import 'package:dartz/dartz.dart';
import 'package:mobx_triple/mobx_triple.dart';

import '../../../../../../shared/helpers/either_adapter/dartz_either_adapter.dart';
import '../../../../../../shared/helpers/errors.dart';
import '../../domain/entities/dispute_entity.dart';

class DisputeStore extends MobXStore<Failure, DisputeEntity> {
  DisputeStore() : super(DisputeEntity());

  Future<void> setDispute(Either<Failure, DisputeEntity> value) async {
    setLoading(true);

    await executeEither(() async => DartzEitherAdapter(value),
        delay: Duration(milliseconds: 0));

    setLoading(false);
  }

  Future<void> clear() async {
    setError(DefaultFailure(message: ""));
    update(DisputeEntity());
  }
}
