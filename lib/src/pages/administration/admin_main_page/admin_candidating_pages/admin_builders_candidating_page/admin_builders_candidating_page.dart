import 'package:buildup/entities/builder.dart';
import 'package:buildup/src/pages/administration/admin_main_page/admin_candidating_pages/admin_builders_candidating_page/widgets/admin_candidating_builder_card.dart';
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
        
        return Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final BuBuilder builder in candidatingBuildersStore.builders) 
                AdminCandidatingBuilderCard(builder: builder)
            ],
          ),
        );
      },
    );
  }
}