part of 'document_cubit.dart';

@freezed
class DocumentState with _$DocumentState {
  const factory DocumentState.initial() = _Initial;

  const factory DocumentState.creating(List<DocumentEntity> data) = _Creating;

  const factory DocumentState.loading() = _Loading;

  const factory DocumentState.loaded(List<DocumentEntity> data) = _Loaded;

  const factory DocumentState.updating(List<DocumentEntity> data) =
      _Updatingting;

  const factory DocumentState.error(Failure failure) = _Error;
}
