import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/utils/validator/validator.dart';
import '../../domain/entities/custom_grid_entity.dart';
import '../bloc/grid_cubit/grid_cubit.dart';

const minVal = 0;
const maxVal = 100;

void showCreateGridBottomSheet(BuildContext context) async {
  final key = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final rowController = TextEditingController();
  final columnController = TextEditingController();

  bool loading = false;

  showModalBottomSheet(
    context: context,
    isDismissible: false,
    isScrollControlled: true,
    routeSettings: const RouteSettings(name: "create_grid_bottom_sheet"),
    builder: (context) {
      return StatefulBuilder(builder: (context, setState) {
        void createNewSheet(BuildContext context) {
          if (key.currentState?.validate() ?? false) {
            setState(() {
              loading = true;
            });
            final title = titleController.text;
            final row = int.parse(rowController.text);
            final column = int.parse(columnController.text);

            final doc = DocumentEntity.create(title);
            context.read<GridCubit>().create(doc, row, column);
            setState(() {
              loading = false;
            });
            Navigator.pop(context);
          }
          return;
        }

        return Form(
          key: key,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Container(
            padding: const EdgeInsets.all(15.0),
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10.0),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text("Create New Sheet", style: textTheme.titleMedium),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.clear),
                    ),
                  ],
                ),
                TextFormField(
                  enabled: !loading,
                  controller: titleController,
                  decoration: const InputDecoration(labelText: "Title"),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  validator: FormValidator([
                    RequiredValidator(),
                  ]),
                ),
                const Gap(20.0),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: TextFormField(
                        enabled: !loading,
                        controller: rowController,
                        decoration:
                            const InputDecoration(labelText: "No. of Row"),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(2),
                        ],
                        validator: FormValidator([
                          RequiredValidator(),
                          MinimumLengthValidator(minLength: 1),
                          MaximumLengthValidator(maxLength: 2),
                          MinimumValueValidator(minValue: minVal),
                          MaximumValueValidator(maxValue: maxVal),
                        ]),
                      ),
                    ),
                    const Gap(20.0),
                    Expanded(
                      child: TextFormField(
                        enabled: !loading,
                        controller: columnController,
                        onFieldSubmitted: (_) => createNewSheet(context),
                        decoration:
                            const InputDecoration(labelText: "No. of Column"),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        maxLengthEnforcement:
                            MaxLengthEnforcement.truncateAfterCompositionEnds,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(2),
                        ],
                        validator: FormValidator([
                          RequiredValidator(),
                          MinimumLengthValidator(minLength: 1),
                          MaximumLengthValidator(maxLength: 2),
                          MinimumValueValidator(minValue: minVal),
                          MaximumValueValidator(maxValue: maxVal),
                        ]),
                      ),
                    ),
                  ],
                ),
                const Gap(20.0),
                SizedBox(
                  width: double.infinity,
                  height: kToolbarHeight,
                  child: ElevatedButton(
                    onPressed: loading ? null : () => createNewSheet(context),
                    child: loading
                        ? const CircularProgressIndicator()
                        : const Text("Create"),
                  ),
                ),
              ],
            ),
          ),
        );
      });
    },
  );
}
