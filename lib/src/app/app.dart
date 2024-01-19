import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../routes/app_router.dart';
import '../core/config/app_config.dart';
import '../core/theme/default_theme.dart';
import '../features/grid/presentation/bloc/document_cubit/document_cubit.dart';
import '../features/grid/presentation/bloc/grid_cubit/grid_cubit.dart';
import 'injection/injection.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DocumentCubit>(
          create: (context) => sl()..fetch(),
        ),
        BlocProvider<GridCubit>(
          create: (context) => sl(),
        ),
      ],
      child: MaterialApp.router(
        key: AppConfig.appKey,
        title: 'Mobigic',
        debugShowCheckedModeBanner: false,
        theme: DefaultTheme.instance.light,
        themeMode: ThemeMode.light,
        routerConfig: AppRouter.instance.router,
      ),
    );
  }
}
