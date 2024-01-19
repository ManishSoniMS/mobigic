import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/base/usecase.dart';
import '../../../../../core/error/failure.dart';
import '../../../domain/entities/custom_grid_entity.dart';
import '../../../domain/use_cases/create_document_usecase.dart';
import '../../../domain/use_cases/delete_document_usecase.dart';
import '../../../domain/use_cases/fetch_all_documents_usecase.dart';
import '../../../domain/use_cases/update_document_usecase.dart';

part 'document_state.dart';
part 'document_cubit.freezed.dart';

@singleton
class DocumentCubit extends Cubit<DocumentState> {
  DocumentCubit(
    this._createDocument,
    this._updateDocument,
    this._fetchDocuments,
    this._deleteDocument,
  ) : super(const DocumentState.initial());

  final CreateDocumentUsecase _createDocument;
  final UpdateDocumentUsecase _updateDocument;
  final FetchDocumentsUsecase _fetchDocuments;
  final DeleteDocumentUsecase _deleteDocument;

  Future<void> fetch() async {
    final result = await _fetchDocuments.call(const NoParams());
    result.fold(
      (l) => emit(DocumentState.error(l)),
      (r) => emit(DocumentState.loaded(r)),
    );
  }

  Future<void> create(DocumentEntity doc) async {
    final List<DocumentEntity> existing = state.maybeWhen(
      orElse: () => [],
      creating: (_) => _,
      loaded: (_) => _,
      updating: (_) => _,
    );

    emit(DocumentState.creating(existing));

    final result = await _createDocument.call(doc);
    result.fold(
      (l) => emit(DocumentState.error(l)),
      (r) => emit(DocumentState.loaded(r)),
    );
  }

  Future<void> delete(String id) async {
    final result = await _deleteDocument.call(id);
    result.fold(
      (l) => emit(DocumentState.error(l)),
      (r) => emit(DocumentState.loaded(r)),
    );
  }

  Future<void> update(DocumentEntity doc) async {
    final result = await _updateDocument.call(doc);
    result.fold(
      (l) => emit(DocumentState.error(l)),
      (r) => emit(DocumentState.loaded(r)),
    );
  }
}
