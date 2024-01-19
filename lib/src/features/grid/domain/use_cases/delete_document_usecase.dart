import 'package:injectable/injectable.dart';

import '../../../../core/base/type_defs.dart';
import '../../../../core/base/usecase.dart';
import '../entities/custom_grid_entity.dart';
import '../repositories/local_repository.dart';

@lazySingleton
class DeleteDocumentUsecase extends IUseCase<List<DocumentEntity>, String> {
  const DeleteDocumentUsecase(this._repository);

  final LocalRepository _repository;

  @override
  FailureOr<List<DocumentEntity>> call(String param) async {
    return await _repository.deleteData(param);
  }
}
