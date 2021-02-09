import 'package:flutter/material.dart';

class ProcessImage extends StatelessWidget {
  const ProcessImage({Key key, @required this.imageName}) : super(key: key);

  final String imageName;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Image.asset(
          "assets/candidating_process/$imageName.png",
          width: constraints.maxWidth > 512 ? 512 : constraints.maxWidth
        );
      },
    ); 
  }
}