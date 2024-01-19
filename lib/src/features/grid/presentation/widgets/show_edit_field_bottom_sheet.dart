import 'package:flutter/material.dart';

import '../../domain/entities/custom_grid_entity.dart';

Future<String> showEditFieldBottomSheet(
    BuildContext context, CustomGridEntity data) async {
  final controller = TextEditingController(text: data.value.trim());

  String val = controller.text;

  void updateValue() {
    Navigator.pop(context);
    val = controller.text;
  }

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    routeSettings: const RouteSettings(name: "edit_field_bottom_sheet"),
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(15.0),
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10.0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => updateValue(),
              ),
            ),
            IconButton(
              onPressed: () => updateValue(),
              icon: const Icon(Icons.check),
            ),
          ],
        ),
      );
    },
  );

  return val;
}
