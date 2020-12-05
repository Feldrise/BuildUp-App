import 'package:buildup/src/shared/dialogs/loading_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dialogs {
  // Loading dialog
  static Future showLoadingDialog(
    BuildContext context,
    GlobalKey key,
    String message,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => LoadingDialog(key: key, statusMessage: message,)
    );
  }
}