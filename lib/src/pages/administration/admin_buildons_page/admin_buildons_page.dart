
import 'package:buildup/entities/buildons/buildon.dart';
import 'package:buildup/src/pages/administration/admin_buildons_page/diaogs/admin_buildon_update_dialog.dart';
import 'package:buildup/src/pages/administration/admin_buildons_page/widgets/admin_buildons_list_view.dart';
import 'package:buildup/src/providers/buildons_store.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/src/shared/widgets/bu_appbar.dart';
import 'package:buildup/src/shared/widgets/bu_button.dart';
import 'package:buildup/src/shared/widgets/bu_status_message.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminBuildOnsPage extends StatefulWidget {
  @override
  _AdminBuildOnsPageState createState() => _AdminBuildOnsPageState();
}

class _AdminBuildOnsPageState extends State<AdminBuildOnsPage> {
  BuildOn _activeBuildOn;

  bool _isUpToDate = true;

  @override
  Widget build(BuildContext context) {
    return Consumer2<BuildOnsStore, UserStore>(
      builder: (context, buildOnsStore, userStore, child) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _activeBuildOn = null;
            });
          },
          child: Scaffold(
            backgroundColor: colorScaffoldGrey,
            appBar: BuAppBar(
              title: Container(),
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
                    onPressed: _isUpToDate ? null : _save
                  ),
                )
              ],
            ),
            body: LayoutBuilder(
              builder: (context, constraints) {
                final double panelWidth = constraints.maxWidth > 800 ? 400 : constraints.maxWidth;

                return Row(
                  children: [
                    Expanded(
                      child: buildCenterWidget(buildOnsStore, userStore),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: _activeBuildOn != null ? panelWidth : 0.0,
                      child: AdminBuildOnUpdateDialog(
                        buildOn: _activeBuildOn, 
                        onUpdated: _haveUpdate, 
                        onClosed: _closeActiveBuildOn
                      )
                    )
                  ],
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _addNewBuildOn(buildOnsStore),
              child: const Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }

  Widget buildCenterWidget(BuildOnsStore buildOnsStore, UserStore userStore) {
    if (buildOnsStore.hasData) {
      return AdminBuildOnsListView(
        buildOnRequestUpdate: _buildOnRequestUpdate,
        activeBuildOn: _activeBuildOn, 
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
          
          return AdminBuildOnsListView(
            buildOnRequestUpdate: _buildOnRequestUpdate, 
            activeBuildOn: _activeBuildOn, 
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

  Future _buildOnRequestUpdate(BuildOn toUpdate) async {
    if (_activeBuildOn != null) {
      setState(() {
        _activeBuildOn = null;
      });

      await Future<void>.delayed(const Duration(milliseconds: 50));
    }
    setState(() {
      _activeBuildOn = toUpdate;
    });
  }

  void _haveUpdate() {
    if (!_isUpToDate) {
      return;
    }

    setState(() {
      _isUpToDate = false;
    });
  }

  void _closeActiveBuildOn() {
    setState(() {
      _activeBuildOn = null;
    });
  }

  void _addNewBuildOn(BuildOnsStore buildOnsStore) {
    BuildOn newBuildOn = BuildOn();
    buildOnsStore.loadedBuildOns.add(newBuildOn);
    buildOnsStore.buildonUpdated();

    setState(() {
      _isUpToDate = false;
      _activeBuildOn = newBuildOn;
    });
  }

  Future _save() async {

  }
}