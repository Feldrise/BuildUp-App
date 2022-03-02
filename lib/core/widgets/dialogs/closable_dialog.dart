import 'package:buildup/core/utils/screen_utils.dart';
import 'package:buildup/core/widgets/dialogs/dialog_header.dart';
import 'package:flutter/material.dart';

class ClosableDialog extends StatelessWidget {
  const ClosableDialog({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1002),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border(
            top: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 4
            )
          )
        ),
        child: Padding(
          padding: EdgeInsets.all(ScreenUtils.instance.horizontalPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // The header
              DialogHeader(title: title),
              const SizedBox(height: 12,),

              // The content
              Flexible(
                child: SingleChildScrollView(
                  child: child,
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}