// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../external/local_db.dart' as _i4;
import '../../features/grid/data/repositories/local_repository_impl.dart'
    as _i7;
import '../../features/grid/data/sources/local_source.dart' as _i5;
import '../../features/grid/domain/repositories/local_repository.dart' as _i6;
import '../../features/grid/domain/use_cases/create_document_usecase.dart'
    as _i9;
import '../../features/grid/domain/use_cases/delete_document_usecase.dart'
    as _i10;
import '../../features/grid/domain/use_cases/fetch_all_documents_usecase.dart'
    as _i11;
import '../../features/grid/domain/use_cases/update_document_usecase.dart'
    as _i8;
import '../../features/grid/presentation/bloc/document_cubit/document_cubit.dart'
    as _i12;
import '../../features/grid/presentation/bloc/grid_cubit/grid_cubit.dart'
    as _i3;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initSL(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.GridCubit>(() => _i3.GridCubit());
  gh.singleton<_i4.LocalDatabase>(
    _i4.LocalDatabase.getInstance(),
    dispose: (i) => i.dispose(),
  );
  gh.lazySingleton<_i5.LocalSource>(
      () => _i5.LocalSourceImpl(gh<_i4.LocalDatabase>()));
  gh.lazySingleton<_i6.LocalRepository>(
      () => _i7.LocalRepositoryImpl(gh<_i5.LocalSource>()));
  gh.lazySingleton<_i8.UpdateDocumentUsecase>(
      () => _i8.UpdateDocumentUsecase(gh<_i6.LocalRepository>()));
  gh.lazySingleton<_i9.CreateDocumentUsecase>(
      () => _i9.CreateDocumentUsecase(gh<_i6.LocalRepository>()));
  gh.lazySingleton<_i10.DeleteDocumentUsecase>(
      () => _i10.DeleteDocumentUsecase(gh<_i6.LocalRepository>()));
  gh.lazySingleton<_i11.FetchDocumentsUsecase>(
      () => _i11.FetchDocumentsUsecase(gh<_i6.LocalRepository>()));
  gh.singleton<_i12.DocumentCubit>(_i12.DocumentCubit(
    gh<_i9.CreateDocumentUsecase>(),
    gh<_i8.UpdateDocumentUsecase>(),
    gh<_i11.FetchDocumentsUsecase>(),
    gh<_i10.DeleteDocumentUsecase>(),
  ));
  return getIt;
}
