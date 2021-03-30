import 'package:buildup/src/shared/widgets/general/bu_card.dart';
import 'package:buildup/src/shared/widgets/general/bu_loading_indicator.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key, this.statusMessage = ""}) : super(key: key);

  final String statusMessage;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: BuCard(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
          child: BuLoadingIndicator(message: statusMessage,)
        ),
      )
    );
  }
}