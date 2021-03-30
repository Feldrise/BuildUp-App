import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';

class BuNotificationDot extends StatelessWidget {
  const BuNotificationDot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 5,
      backgroundColor: colorPrimary,
    );
  }
}