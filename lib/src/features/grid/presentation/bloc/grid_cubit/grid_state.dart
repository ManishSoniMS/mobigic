part of 'grid_cubit.dart';

@freezed
class GridState with _$GridState {
  const factory GridState.initial() = _Initial;

  const factory GridState.creating() = _Creating;

  const factory GridState.created(DocumentEntity data, bool isNew) = _Created;
}
