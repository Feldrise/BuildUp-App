import 'package:buildup/src/providers/builder_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuilderNotificationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BuilderStore>(
      builder: (context, coachStore, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Actualités", style: Theme.of(context).textTheme.headline4),
            const SizedBox(height: 16,),
            const Text("Vous n'avez pas de nouvelle actualités")
          ],
        );
      },
    );
  }
}