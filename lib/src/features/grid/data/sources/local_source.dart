import 'dart:convert';

import 'package:injectable/injectable.dart';

import '../../../../external/local_db.dart';
import '../../domain/entities/custom_grid_entity.dart';

abstract class LocalSource {
  Future<List<DocumentEntity>> createData(DocumentEntity doc);

  Future<List<DocumentEntity>> fetchAllData();

  Future<List<DocumentEntity>> updateData(DocumentEntity doc);

  Future<List<DocumentEntity>> deleteData(String id);
}

@LazySingleton(as: LocalSource)
class LocalSourceImpl extends LocalSource {
  final LocalDatabase _db;

  LocalSourceImpl(this._db);

  @override
  Future<List<DocumentEntity>> createData(DocumentEntity doc) async {
    final existing = _db.pref.getString("data");

    List toUpdate = [];

    if (existing != null) {
      toUpdate = [doc.toMap(), ...(jsonDecode(existing) as List<dynamic>)];
    } else {
      toUpdate = [doc.toMap()];
    }

    final jsonData = json.encode(toUpdate);
    _db.pref.setString("data", jsonData);

    final result = _db.pref.getString("data");

    final list = List<DocumentEntity>.from(
        jsonDecode(result!).map((e) => DocumentEntity.fromMap(e)));
    return list;
  }

  @override
  Future<List<DocumentEntity>> deleteData(String id) async {
    final result = _db.pref.getString("data");

    final List<DocumentEntity> existing = List<DocumentEntity>.from(
        jsonDecode(result!).map((e) => DocumentEntity.fromMap(e)));

    final index = existing.indexWhere((element) => element.id == id);

    existing.removeAt(index);

    final toUpdate = existing.map((e) => e.toMap()).toList();

    final jsonData = json.encode(toUpdate);
    _db.pref.setString("data", jsonData);
    return existing;
  }

  @override
  Future<List<DocumentEntity>> fetchAllData() async {
    final result = _db.pref.getString("data");
    if (result == null) {
      return [];
    }
    final List<DocumentEntity> list = List<DocumentEntity>.from(
        jsonDecode(result).map((e) => DocumentEntity.fromMap(e)));
    return list;
  }

  @override
  Future<List<DocumentEntity>> updateData(DocumentEntity doc) async {
    final result = _db.pref.getString("data");

    final existing = List<DocumentEntity>.from(
        jsonDecode(result!).map((e) => DocumentEntity.fromMap(e)));

    final index = existing.indexWhere((element) => element.id == doc.id);

    existing.removeAt(index);
    existing.insert(0, doc.copyWith(updatedAt: DateTime.now()));

    final toUpdate = existing.map((e) => e.toMap()).toList();

    final jsonData = json.encode(toUpdate);
    _db.pref.setString("data", jsonData);
    return existing;
  }
}
