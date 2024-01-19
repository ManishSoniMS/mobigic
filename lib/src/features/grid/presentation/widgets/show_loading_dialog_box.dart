import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

Future<void> showLoadingDialogBox(BuildContext context) {
  return showDialog(
      context: context,
      routeSettings: const RouteSettings(name: "loading_dialog_box"),
      builder: (context) {
        return const AlertDialog(
          content: Column(
            children: [
              CircularProgressIndicator(),
              Gap(20.0),
              Text("Loading..."),
            ],
          ),
        );
      });
}
