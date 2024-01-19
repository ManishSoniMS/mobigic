import 'package:injectable/injectable.dart';

import '../../../../core/base/type_defs.dart';
import '../../../../core/base/usecase.dart';
import '../entities/custom_grid_entity.dart';
import '../repositories/local_repository.dart';

@lazySingleton
class UpdateDocumentUsecase
    extends IUseCase<List<DocumentEntity>, DocumentEntity> {
  const UpdateDocumentUsecase(this._repository);

  final LocalRepository _repository;

  @override
  FailureOr<List<DocumentEntity>> call(DocumentEntity param) async {
    return await _repository.updateData(param);
  }
}
