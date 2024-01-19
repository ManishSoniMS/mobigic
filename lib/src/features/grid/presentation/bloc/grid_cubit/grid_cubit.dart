import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/custom_grid_entity.dart';

part 'grid_state.dart';
part 'grid_cubit.freezed.dart';

@injectable
class GridCubit extends Cubit<GridState> {
  GridCubit() : super(const GridState.initial());

  Future<void> loadFromList(DocumentEntity doc) async {
    emit(const GridState.creating());
    emit(GridState.created(doc, false));
  }

  Future<void> create(DocumentEntity doc, int row, int column) async {
    emit(const GridState.creating());
    List<RowEntity> data = [];
    for (int r = 1; r <= row; r++) {
      List<CustomGridEntity> val = [];
      for (int c = 1; c <= column; c++) {
        val.add(
          CustomGridEntity(
            id: "$r$c",
            rowId: "$r",
            value: (r * c).toString(),
          ),
        );
      }
      data.add(RowEntity(id: "$r", value: val));
    }
    final newDoc = doc.copyWith(data: data);
    emit(GridState.created(newDoc, true));
  }

  Future<void> search(String query) async {
    state.whenOrNull(created: (data, isNew) {
      final List<RowEntity> newData = data.data.map((rowEntity) {
        final matched = rowEntity.value.any((gridEntity) =>
            gridEntity.searchMatched ||
            gridEntity.value.toLowerCase().contains(query.toLowerCase()));

        if (matched) {
          final gridList = rowEntity.value;

          final List<CustomGridEntity> updated = gridList.map((e) {
            // if query is empty, unselect all
            if (query.isEmpty) return e.copyWith(searchMatched: false);

            // marked matched, if query match
            if (e.value.toLowerCase().contains(query.toLowerCase())) {
              return e.copyWith(searchMatched: true);
            }

            // mark un-match, if matched previously not this time
            return e.copyWith(searchMatched: false);
          }).toList();

          return rowEntity.copyWith(value: updated);
        }

        return rowEntity;
      }).toList();

      emit(GridState.created(data.copyWith(data: newData), false));
    });
  }

  Future<void> updatedValue(CustomGridEntity input) async {
    state.whenOrNull(created: (data, isNew) {
      final List<RowEntity> newData = data.data.map((rowEntity) {
        if (rowEntity.id == input.rowId) {
          final grid = rowEntity.value.map((gridEntity) {
            if (gridEntity.id == input.id) {
              return gridEntity.copyWith(value: input.value);
            }
            return gridEntity;
          }).toList();

          return rowEntity.copyWith(value: grid);
        }
        return rowEntity;
      }).toList();

      emit(GridState.created(data.copyWith(data: newData), false));
    });
  }

  Future<void> clearSearch() async {
    state.whenOrNull(created: (data, isNew) {
      final List<RowEntity> newData = data.data.map((rowEntity) {
        final matched =
            rowEntity.value.any((gridEntity) => gridEntity.searchMatched);

        if (matched) {
          final gridList = rowEntity.value;

          final List<CustomGridEntity> updated = gridList.map((e) {
            return e.copyWith(searchMatched: false);
          }).toList();

          return rowEntity.copyWith(value: updated);
        }

        return rowEntity;
      }).toList();

      emit(GridState.created(data.copyWith(data: newData), false));
    });
  }
}
