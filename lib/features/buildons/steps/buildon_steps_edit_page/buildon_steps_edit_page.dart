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
  final GlobalKey<BuildOnStepEditListState> _editListKey = GlobalKey<BuildOnStepEditListState>();

  String _statusMessage = "";
  bool _isSuccessfull = true;
  bool _shouldRefetch = false;

  QueryOptions<dynamic> _queryOptions() {
    return QueryOptions<dynamic>(
      document: gql(qBuildOnSteps),
      variables: <String, dynamic>{
        "buildOnID": widget.buildOnId,
      },
    );
  }

 MutationOptions<dynamic> _createMutationOptions() {
    return MutationOptions<dynamic>(
      document: gql(qMutCreateBuildOnStep),
      onError: _onMutationError,
      onCompleted: _onMutationComplete
    );
  }

  MutationOptions<dynamic> _updateMutationOptions() {
    return MutationOptions<dynamic>(
      document: gql(qMutUpdateBuildOnStep),
      onError: _onMutationError,
      onCompleted: _onMutationComplete
    );
  }

  void _onMutationError(OperationException? error) {
    _isSuccessfull = false;
    _statusMessage = "Une ou plusieurs étapes n'ont pas pu être crée...";
    _shouldRefetch = false;
  }

  void _onMutationComplete(dynamic data) {
    if (data == null) return;

    if (_isSuccessfull) {
      _statusMessage = "Tout à bien été sauvegardé.";
      _shouldRefetch = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Mutation<dynamic>(
      options: _createMutationOptions(),
      builder: (createRunMutation, createMutationResult) {
        return Mutation<dynamic>(
          options: _updateMutationOptions(),
          builder: (updateRunMutation, updateMutationResult) {
            return Scaffold(
              appBar: AppBar(
                actions: [
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_editListKey.currentState != null) {
                          await _editListKey.currentState!.save();
                        }
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
                  if (_shouldRefetch && refetch != null) {
                    refetch();
                    _shouldRefetch = false;
                  }

                  if (
                    result.isLoading ||
                    (createMutationResult?.isLoading ?? false) ||
                    (updateMutationResult?.isLoading ?? false)
                  ) {
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

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (_statusMessage.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: ScreenUtils.instance.horizontalPadding
                          ),
                          child: BuStatusMessage(
                            type: _isSuccessfull ? BuStatusMessageType.success : BuStatusMessageType.error,
                            message: _statusMessage,
                          ),
                        ),
                      
                      Flexible(child: _buildContent(context, buildOn.steps, createRunMutation, updateRunMutation))
                    ],
                  );
                },
              ),
            );
          }
        );
      }
    );
  }

  Widget _buildContent(BuildContext context, List<BuildOnStep> steps, RunMutation createMutation, RunMutation updateMutation) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool fullScreenDialog =  constraints.maxWidth <= 800;
        final double maxPanelWidth = fullScreenDialog ? constraints.maxWidth : 500;
        
        return BuildOnStepEditList(
          key: _editListKey,
          steps: steps,
          maxPanelWidth: maxPanelWidth,
          creationMutation: createMutation,
          updateMutation: updateMutation,
          buildOnId: widget.buildOnId,
        );
        
      },
    );
  }
}