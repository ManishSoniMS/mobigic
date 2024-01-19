import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../routes/routes.dart';
import '../bloc/document_cubit/document_cubit.dart';
import '../bloc/grid_cubit/grid_cubit.dart';
import '../widgets/search_bar.dart';
import '../widgets/table_tab.dart';

class TablePage extends StatelessWidget {
  const TablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<GridCubit, GridState>(
            builder: (context, state) {
              return state.maybeWhen(
                  orElse: () => const SizedBox.shrink(),
                  created: (doc, isNew) {
                    return Text(doc.title);
                  });
            },
          ),
          actions: [
            BlocBuilder<GridCubit, GridState>(
              builder: (context, state) {
                return state.maybeWhen(
                    orElse: () => const SizedBox.shrink(),
                    created: (doc, isNew) {
                      return IconButton(
                        onPressed: () {
                          context.read<DocumentCubit>().update(doc);
                          context.pushReplacement(Routes.home);
                        },
                        icon: const Icon(Icons.exit_to_app),
                      );
                    });
              },
            ),
          ],
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: SearchBarWidget(),
          ),
        ),
        body: BlocBuilder<GridCubit, GridState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              created: (data, isNew) {
                if (isNew) {
                  context.read<DocumentCubit>().create(data);
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      border: TableBorder.all(),
                      headingRowHeight: 0.0,
                      columnSpacing: 0.0,
                      columns: [
                        for (int i = 1; i <= data.data.first.value.length; i++)
                          DataColumn(
                            label: Center(child: Text('ID $i')),
                          ),
                      ],
                      rows: data.data
                          .map(
                            (e) => DataRow(
                              cells: e.value
                                  .map(
                                    (e) => DataCell(
                                      CustomTableTab(data: e),
                                    ),
                                  )
                                  .toList(),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
