import 'package:buildup/core/utils/screen_utils.dart';
import 'package:buildup/core/widgets/bu_status_message.dart';
import 'package:buildup/features/buildons/buildon.dart';
import 'package:buildup/features/buildons/steps/buildon_step.dart';
import 'package:buildup/features/buildons/steps/buildon_steps_edit_page/widgets/buildon_step_edit_list.dart';
import 'package:buildup/features/buildons/steps/buildon_steps_graphql.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class BuildOnStepEditPage extends StatefulWidget {
  const BuildOnStepEditPage({
    Key? key,
    required this.buildOnId
  }) : super(key: key);

  final String buildOnId;

  @override
  State<BuildOnStepEditPage> createState() => _BuildOnStepEditPageState();
}

class _BuildOnStepEditPageState extends State<BuildOnStepEditPage> {
  QueryOptions<dynamic> _queryOptions() {
    return QueryOptions<dynamic>(
      document: gql(qBuildOnSteps),
      variables: <String, dynamic>{
        "buildOnID": widget.buildOnId
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                // TODO: do
              },
              child: Row(
                children: const [
                  Icon(Icons.save),
                  SizedBox(width: 4,),
                  Text("Sauvegarder")
                ],
              )
            ),
          ),
        ],
      ),
      body: Query<dynamic>(
        options: _queryOptions(),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator(),);
          }

          if (result.hasException) {
            return Padding(
              padding: EdgeInsets.all(ScreenUtils.instance.horizontalPadding),
              child: const BuStatusMessage(
                title: "Erreur de chargement",
                message: "Nous ne parvenons pas à charger la liste des étapes... Si ce problème persite, n'hésitez pas à nous contacter.",
              ),
            );
          }

          final BuildOn buildOn = BuildOn.fromJson(result.data!["buildon"] as Map<String, dynamic>);

          return _buildContent(context, buildOn.steps);
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<BuildOnStep> steps) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // We return the empty info widget if the list is empty
        if (steps.isEmpty) return _buildEmptyInfo(context);

        final bool fullScreenDialog =  constraints.maxWidth <= 800;
        final double maxPanelWidth = fullScreenDialog ? constraints.maxWidth : 500;
        
        return BuildOnStepEditList(
          steps: steps,
          maxPanelWidth: maxPanelWidth,
        );
        
      },
    );
  }

  Widget _buildEmptyInfo(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.list, 
            size: 92,
            color: Theme.of(context).textTheme.caption!.color
          ),
          const SizedBox(height: 8,),
          Text(
            "Il n'y a aucune étape pour le moment. Ajoutez-en un en appuyant sur le bouton +",
            style: TextStyle(
              color: Theme.of(context).textTheme.caption!.color
            ),
          )
        ],
      ),
    );
  }
}