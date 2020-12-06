
import 'package:buildup/entities/buildons/buildon.dart';
import 'package:buildup/entities/buildons/buildon_step.dart';
import 'package:buildup/src/pages/administration/admin_buildon_steps_page/dialogs/admin_buildon_step_update_dialog.dart';
import 'package:buildup/src/pages/administration/admin_buildon_steps_page/widgets/admin_buildon_steps_list_view.dart';
import 'package:buildup/src/providers/buildons_store.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/src/shared/dialogs/dialogs.dart';
import 'package:buildup/src/shared/widgets/bu_appbar.dart';
import 'package:buildup/src/shared/widgets/bu_button.dart';
import 'package:buildup/src/shared/widgets/bu_status_message.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminBuildOnStepsPage extends StatefulWidget {
  const AdminBuildOnStepsPage({Key key, @required this.buildOn}) : super(key: key);
  
  final BuildOn buildOn;

  @override
  _AdminBuildOnStepsPageState createState() => _AdminBuildOnStepsPageState();
}

class _AdminBuildOnStepsPageState extends State<AdminBuildOnStepsPage> {
  BuildOnStep _activeBuildOnStep;

  bool _hasError = false;
  bool _isUpToDate = true;
  String _statusMessage = "";

  @override
  Widget build(BuildContext context) {
    return Consumer2<BuildOnsStore, UserStore>(
      builder: (context, buildOnsStore, userStore, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final bool fullScreenDialog =  constraints.maxWidth <= 800;
            final double panelWidth = fullScreenDialog ? constraints.maxWidth : 400;

            return Scaffold(
              backgroundColor: colorScaffoldGrey,
              appBar: BuAppBar(
                title: Text(widget.buildOn.name, style: Theme.of(context).textTheme.headline5,),
                actions: [
                  if (!_isUpToDate) 
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: BuButton(
                        buttonType: BuButtonType.secondary,
                        text: "Annuler", 
                        onPressed: () {}
                      ),
                    ),
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: BuButton(
                      icon: Icons.save,
                      text: "Enregister", 
                      onPressed: _isUpToDate ? null : () => _save(buildOnsStore)
                    ),
                  )
                ],
              ),
              body: Row(
                children: [
                  Expanded(
                    child: buildCenterWidget(buildOnsStore, userStore),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: _activeBuildOnStep != null ? panelWidth : 0.0,
                    child: AdminBuildOnStepUpdateDialog(
                      buildOnStep: _activeBuildOnStep, 
                      onUpdated: _haveUpdate, 
                      onClosed: _closeActiveBuildOn
                    )
                  )
                ],
              ),
              floatingActionButton: Visibility(
                visible: !fullScreenDialog || _activeBuildOnStep == null,
                child: Padding(
                  padding: EdgeInsets.only(right: (_activeBuildOnStep != null) ? panelWidth : 0),
                  child: FloatingActionButton(
                    backgroundColor: colorPrimary,
                    onPressed: () => _addNewBuildOnStep(buildOnsStore),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
              )
            );
          },
        );
      },
    );
  }

  Widget buildCenterWidget(BuildOnsStore buildOnsStore, UserStore userStore) {
    if (buildOnsStore.hasData) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_statusMessage.isNotEmpty) ...{ 
              BuStatusMessage(
                type: _hasError ? BuStatusMessageType.error : BuStatusMessageType.success,
                title: _hasError ? "Erreur" : "Bravo !",
                message: _statusMessage,
              ),
              const SizedBox(height: 15),
            },
            Expanded(
              child: AdminBuildOnStepsListView(
                buildOn: widget.buildOn,
                buildOnStepRequestUpdate: _buildOnStepRequestUpdate,
                activeBuildOnStep: _activeBuildOnStep, 
                onUpdated: _haveUpdate,
              ),
            )
          ]
        )
      );
    }

    return FutureBuilder<void>(
      future: buildOnsStore.buildons(userStore.authentificationHeader),
      builder: (context, snaphsot) {
        if (snaphsot.connectionState == ConnectionState.done) {
          if (snaphsot.hasError) {
            return Center(
              child: BuStatusMessage(
                title: "Erreur lors de la récupération des build-ons",
                message: snaphsot.error.toString(),
              ),
            );
          }
          
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_statusMessage.isNotEmpty) ...{ 
                  BuStatusMessage(
                    type: _hasError ? BuStatusMessageType.error : BuStatusMessageType.success,
                    title: _hasError ? "Erreur" : "Bravo !",
                    message: _statusMessage,
                  ),
                  const SizedBox(height: 15),
                },
                Expanded(
                  child: AdminBuildOnStepsListView(
                    buildOn: widget.buildOn,
                    buildOnStepRequestUpdate: _buildOnStepRequestUpdate,
                    activeBuildOnStep: _activeBuildOnStep, 
                    onUpdated: _haveUpdate,
                  ),
                ),
              ],
            ),
          );
        }

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                SizedBox(
                  width: 84,
                  height: 84,
                  child: CircularProgressIndicator()
                ),
                SizedBox(height: 30,),
                Text("Récupération des données des build-ons")
              ]
            ),
          ),
        );
      },
    );
  }

  Future _buildOnStepRequestUpdate(BuildOnStep toUpdate) async {
    if (_activeBuildOnStep != null) {
      setState(() {
        _activeBuildOnStep = null;
      });

      await Future<void>.delayed(const Duration(milliseconds: 50));
    }
    setState(() {
      _activeBuildOnStep = toUpdate;
    });
  }

  void _haveUpdate() {
    if (!_isUpToDate) {
      return;
    }

    setState(() {
      _isUpToDate = false;
      _hasError = false;
      _statusMessage = "";
    });
  }

  void _closeActiveBuildOn() {
    setState(() {
      _activeBuildOnStep = null;
    });
  }

  void _addNewBuildOnStep(BuildOnsStore buildOnsStore) {
    final BuildOnStep newBuildOnStep = BuildOnStep();
    widget.buildOn.steps.add(newBuildOnStep);
    buildOnsStore.buildonUpdated();

    setState(() {
      _isUpToDate = false;
      _activeBuildOnStep = newBuildOnStep;
    });
  }

  Future _save(BuildOnsStore buildOnsStore) async {
    final GlobalKey<State> keyLoader = GlobalKey<State>();
    Dialogs.showLoadingDialog(context, keyLoader, "Veuillez patienter, l'ensemble de vos modifications sont en cours d'enregistrement..."); 

    try {
      final String authorization = Provider.of<UserStore>(context, listen: false).authentificationHeader;
      await buildOnsStore.syncBuildOnSteps(authorization, widget.buildOn);

      setState(() {
        _isUpToDate = true;
        _hasError = false;
        _statusMessage = "Les étapes ont été correctement enregistrés";
      });
    } on Exception catch(e) {
      setState(() {
        _hasError = true;
        _statusMessage = "Impossible d'enregistrer les étapes : ${e.toString()}";
      });
    }
    
    Navigator.of(keyLoader.currentContext,rootNavigator: true).pop(); 
  }
}