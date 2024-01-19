import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../../routes/routes.dart';
import '../../domain/entities/custom_grid_entity.dart';
import '../bloc/document_cubit/document_cubit.dart';
import '../bloc/grid_cubit/grid_cubit.dart';
import '../widgets/create_grid_bottom_sheet.dart';
import '../widgets/show_loading_dialog_box.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Mobigic"),
      ),
      body: BlocListener<GridCubit, GridState>(
        listener: (context, state) {
          state.whenOrNull(creating: () {
            showLoadingDialogBox(context);
          }, created: (_, __) {
            context.pushReplacement(Routes.table);
          });
        },
        child: BlocBuilder<DocumentCubit, DocumentState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () => const Center(child: CircularProgressIndicator()),
              creating: (docs) => buildBody(docs),
              loaded: (docs) => buildBody(docs),
              updating: (docs) => buildBody(docs),
              error: (error) => Center(
                child: Text(error.message),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showCreateGridBottomSheet(context),
        child: const Icon(Icons.edit_document),
      ),
    );
  }

  Widget buildBody(List<DocumentEntity> docs) {
    if (docs.isEmpty) {
      return const Center(
        child: Text("No Document Found."),
      );
    }
    return ListView.builder(
      itemCount: docs.length,
      itemBuilder: (context, index) {
        final doc = docs[index];
        return ListTile(
          onTap: () {
            context.pushReplacement(Routes.table);
            context.read<GridCubit>().loadFromList(doc);
          },
          title: Text(doc.title),
          subtitle: Text(DateFormat("dd/MM/yy hh:mm a").format(doc.updatedAt)),
          trailing: IconButton(
            onPressed: () => context.read<DocumentCubit>().delete(doc.id),
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        );
      },
    );
  }
}
