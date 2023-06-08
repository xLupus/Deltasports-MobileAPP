import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:flutter/material.dart';

bool show = false;

Future<void> snackBar(BuildContext context, String txt) async {
  if (!show) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        content: Text(
          txt,
          textAlign: TextAlign.center,
        ),
        backgroundColor: GlobalColors.red,
      ),
    ).closed.then((value) {
      show = false;
    });
  }
  show = true;
}
