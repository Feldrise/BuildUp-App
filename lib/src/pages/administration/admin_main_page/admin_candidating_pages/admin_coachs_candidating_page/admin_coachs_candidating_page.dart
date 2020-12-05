import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';

class AdminCoachsCandidatingPage extends StatelessWidget {
  const AdminCoachsCandidatingPage({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorScaffoldGrey,
      child: const Center(
        child: Text("Hello candidatures coachs"),
      ),
    );
  }
}