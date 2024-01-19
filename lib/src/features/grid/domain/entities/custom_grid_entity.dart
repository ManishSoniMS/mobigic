import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class DocumentEntity extends Equatable {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String title;
  final List<RowEntity> data;

  const DocumentEntity({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.data,
  });

  @override
  String toString() {
    return 'DocumentEntity{ id: $id, createdAt: $createdAt, updatedAt: $updatedAt, title: $title, data: $data,}';
  }

  DocumentEntity copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? title,
    List<RowEntity>? data,
  }) {
    return DocumentEntity(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      title: title ?? this.title,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
      'title': title,
      'data': data.map((e) => e.toMap()).toList(),
    };
  }

  factory DocumentEntity.create(String title) {
    return DocumentEntity(
      id: const Uuid().v4(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      title: title,
      data: const [],
    );
  }

  factory DocumentEntity.fromMap(Map<String, dynamic> map) {
    return DocumentEntity(
      id: map['id'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      title: map['title'],
      data: List<RowEntity>.from(
          map['data'].map((e) => RowEntity.fromMap(e)).toList()),
    );
  }

  @override
  List<Object?> get props => [
        id,
        createdAt,
        updatedAt,
        title,
        data,
      ];
}

class RowEntity extends Equatable {
  /// row id, e,g., 1
  final String id;

  /// List of [CustomGridEntity]
  final List<CustomGridEntity> value;

  const RowEntity({
    required this.id,
    required this.value,
  });

  @override
  String toString() {
    return 'RowEntity{ id: $id, value: $value,}';
  }

  RowEntity copyWith({
    String? id,
    List<CustomGridEntity>? value,
  }) {
    return RowEntity(
      id: id ?? this.id,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'value': value.map((e) => e.toMap()).toList(),
    };
  }

  factory RowEntity.fromMap(Map<String, dynamic> map) {
    return RowEntity(
      id: map['id'],
      value: List<CustomGridEntity>.from(
        map['value'].map((e) => CustomGridEntity.fromMap(e)).toList(),
      ),
    );
  }

  @override
  List<Object?> get props => [
        id,
        value,
      ];
}

class CustomGridEntity extends Equatable {
  /// Box's id, e.g., 11 (Row ID + Column ID)
  final String id;

  final String rowId;

  ///
  final String value;

  final bool searchMatched;

  const CustomGridEntity({
    required this.id,
    required this.rowId,
    required this.value,
    this.searchMatched = false,
  });

  @override
  String toString() {
    return 'CustomGridEntity{ id: $id, rowId: $rowId, value: $value, searchMatched: $searchMatched}';
  }

  CustomGridEntity copyWith({
    String? id,
    String? rowId,
    String? value,
    bool? searchMatched,
  }) {
    return CustomGridEntity(
      id: id ?? this.id,
      rowId: rowId ?? this.rowId,
      value: value ?? this.value,
      searchMatched: searchMatched ?? this.searchMatched,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rowId': rowId,
      'value': value,
      'searchMatched': searchMatched,
    };
  }

  factory CustomGridEntity.fromMap(Map<String, dynamic> map) {
    return CustomGridEntity(
      id: map['id'],
      rowId: map['rowId'],
      value: map['value'],
      searchMatched: map['searchMatched'] ?? false,
    );
  }

  @override
  List<Object?> get props => [
        id,
        rowId,
        value,
        searchMatched,
      ];
}
