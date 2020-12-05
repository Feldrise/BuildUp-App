import 'package:buildup/src/providers/candidating_builders_store.dart';
import 'package:buildup/src/shared/widgets/bu_status_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminBuildersCandidatingPage extends StatelessWidget {
  const AdminBuildersCandidatingPage({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Consumer<CandidatingBuilderStore>(
      builder: (context, candidatingBuildersStore, child) {
        if (!candidatingBuildersStore.hasData) {
          return const Center(
            child: BuStatusMessage(
              type: BuStatusMessageType.info,
              message: "Il n'y a aucun builder candidatant pour le moment",
            ),
          );
        }
        
        return const Center(child: Text("Hello World"));
      },
    );
  }
}