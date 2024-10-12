import 'dart:developer';

import 'package:flutter/material.dart';

show_log_error(var msg) {
  log(msg);
}

const Color kPrimaryColor = Color(0xff706CFF);

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible:
        false, // Prevents dismissing by tapping outside the dialog
    builder: (BuildContext context) {
      return const AlertDialog(
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text("Loading..."),
          ],
        ),
      );
    },
  );
}
