import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/base/type_defs.dart';
import '../../../../core/error/map_exception_to_error.dart';
import '../../domain/entities/custom_grid_entity.dart';
import '../../domain/repositories/local_repository.dart';
import '../sources/local_source.dart';

@LazySingleton(as: LocalRepository)
class LocalRepositoryImpl extends LocalRepository {
  LocalRepositoryImpl(this._source);
  final LocalSource _source;

  @override
  FailureOr<List<DocumentEntity>> createData(DocumentEntity doc) async {
    try {
      final result = await _source.createData(doc);
      return right(result);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  FailureOr<List<DocumentEntity>> deleteData(String id) async {
    try {
      final result = await _source.deleteData(id);
      return right(result);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  FailureOr<List<DocumentEntity>> fetchAllData() async {
    try {
      final result = await _source.fetchAllData();
      return right(result);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  FailureOr<List<DocumentEntity>> updateData(DocumentEntity doc) async {
    try {
      final result = await _source.updateData(doc);
      return right(result);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
