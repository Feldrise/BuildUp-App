import 'package:buildup/src/shared/widgets/bu_card.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key key, this.statusMessage}) : super(key: key);

  final String statusMessage;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: BuCard(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 84,
                height: 84,
                child: CircularProgressIndicator()
              ),
              const SizedBox(height: 30,),
              Text(statusMessage)
            ]
          ),
        ),
      )
    );
  }
}