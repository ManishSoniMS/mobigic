import '../../../../core/base/type_defs.dart';
import '../entities/custom_grid_entity.dart';

abstract class LocalRepository {
  FailureOr<List<DocumentEntity>> createData(DocumentEntity doc);

  FailureOr<List<DocumentEntity>> fetchAllData();

  FailureOr<List<DocumentEntity>> updateData(DocumentEntity doc);

  FailureOr<List<DocumentEntity>> deleteData(String id);
}
