import 'package:flutter/material.dart';

class BuLoadingIndicator extends StatelessWidget {
  const BuLoadingIndicator({Key? key, required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          width: 84,
          height: 84,
          child: CircularProgressIndicator()
        ),
        const SizedBox(height: 30,),
        Text(message)
      ]
    );
  }
}