import 'package:buildup/core/utils/screen_utils.dart';
import 'package:buildup/core/widgets/bu_status_message.dart';
import 'package:buildup/features/buildons/buildon.dart';
import 'package:buildup/features/buildons/buildons_edit_page/widgets/buildons_edit_list.dart';
import 'package:buildup/features/buildons/buildons_graphql.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

// TODO: make the save button react to changes
class BuildOnsEditPage extends StatefulWidget {
  const BuildOnsEditPage({Key? key}) : super(key: key);

  @override
  State<BuildOnsEditPage> createState() => _BuildOnsEditPageState();
}

class _BuildOnsEditPageState extends State<BuildOnsEditPage> {
  final GlobalKey<BuildOnsEditListState> _editListKey = GlobalKey<BuildOnsEditListState>();

  String _statusMessage = "";
  bool _isSuccessfull = true;
  bool _shouldRefetch = false;

  QueryOptions<dynamic> _queryOptions() {
    return QueryOptions<dynamic>(
      document: gql(qBuildOns)
    );
  }

  MutationOptions<dynamic> _createMutationOptions() {
    return MutationOptions<dynamic>(
      document: gql(qMutCreateBuildOn),
      onError: _onMutationError,
      onCompleted: _onMutationComplete
    );
  }

  MutationOptions<dynamic> _updateMutationOptions() {
    return MutationOptions<dynamic>(
      document: gql(qMutUpdateBuildOn),
      onError: _onMutationError,
      onCompleted: _onMutationComplete
    );
  }

  void _onMutationError(OperationException? error) {
    _isSuccessfull = false;
    _statusMessage = "Un ou plusieurs build-on n'ont pas pu être créé...";
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
                        message: "Nous ne parvenons pas à charger la liste des buildons... Si ce problème persite, n'hésitez pas à nous contacter.",
                      ),
                    );
                  }

                  final List mapsBuildOns = result.data!["buildons"] as List;
                  final List<BuildOn> buildOns = [];

                  for (final map in mapsBuildOns) {
                    buildOns.add(BuildOn.fromJson(map as Map<String, dynamic>));
                  }

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
                      
                      Flexible(child: _buildContent(context, buildOns, createRunMutation, updateRunMutation))
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

  Widget _buildContent(BuildContext context, List<BuildOn> buildOns, RunMutation createMutation, RunMutation updateMutation) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // We return the empty info widget if the list is empty
        if (buildOns.isEmpty) return _buildEmptyInfo(context);

        final bool fullScreenDialog =  constraints.maxWidth <= 800;
        final double maxPanelWidth = fullScreenDialog ? constraints.maxWidth : 500;
        
        return BuildOnsEditList(
          key: _editListKey,
          buildOns: buildOns,
          maxPanelWidth: maxPanelWidth,
          creationMutation: createMutation,
          updateMutation: updateMutation,
        );
        
      },
    );
  }

  Widget _buildEmptyInfo(BuildContext context) {
    return Column(
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
          "Il n'y a aucun Build-On pour le moment. Ajoutez-en un en appuyant sur le bouton +",
          style: TextStyle(
            color: Theme.of(context).textTheme.caption!.color
          ),
        )
      ],
    );
  }
}