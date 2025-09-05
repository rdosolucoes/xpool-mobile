import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../entities/dispute_entity.dart';
import '../repositories/dispute_repository_interface.dart';
import 'interfaces/get_dispute_interface.dart';

class GetDispute implements IGetDispute {
  final IDisputeRepository _disputeRepository;

  GetDispute(this._disputeRepository);

  @override
  Future<Either<Failure, DisputeEntity>> call(int supId, int referenceId) {
    var result = _disputeRepository.get(supId, referenceId);
    return result;
  }
}
