
import 'package:buildup/services/builders_service.dart';
import 'package:buildup/src/pages/administration/admin_active_pages/admin_active_builders_page/widgets/admin_active_builder_card.dart';
import 'package:buildup/src/providers/active_builers_store.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/src/shared/widgets/general/bu_status_message.dart';
import 'package:buildup/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AdminActiveBuildersPage extends StatefulWidget {
  const AdminActiveBuildersPage({Key key,}) : super(key: key);

  @override
  _AdminActiveBuildersPageState createState() => _AdminActiveBuildersPageState();
}

class _AdminActiveBuildersPageState extends State<AdminActiveBuildersPage> {
  bool _hasError = false;
  String _statusMessage = "";

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = ScreenUtils.instance.horizontalPadding;

    return RefreshIndicator(
      onRefresh: _refresh,
      child: Stack(
        children: [
          ListView(), // Here to make the RefreshIndicator working
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_hasError)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: horizontalPadding),
                  child: BuStatusMessage(
                    title: "Erreur",
                    message: _statusMessage,
                  ),
                ),
              Consumer<ActiveBuildersStore>(
                builder: (context, activeBuildersStore, child) {
                  if (!activeBuildersStore.hasData) {
                    return Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 30, horizontal: horizontalPadding),
                        child: const BuStatusMessage(
                          type: BuStatusMessageType.info,
                          message: "Il n'y a aucun builder actif pour le moment",
                        ),
                      ),
                    );
                  }

                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 30, horizontal: horizontalPadding),
                      child: SingleChildScrollView(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Wrap(
                              spacing: 15,
                              runSpacing: 15,
                              children: [
                                for (final builder in activeBuildersStore.builders) 
                                  AdminActiveBuilderCard(
                                    builder: builder,
                                    width: constraints.maxWidth > 500 ? 250 : constraints.maxWidth,
                                  ),
                              ],
                            );
                          },
                        ),
                      )
                    ),
                  );
                }, 
              )
            ]
          )
        ]
      )
    );
  }

  Future _refresh() async {
    final ActiveBuildersStore activeBuildersStore = Provider.of<ActiveBuildersStore>(context, listen: false);
    final UserStore currentUser = Provider.of<UserStore>(context, listen: false);

    try {
      activeBuildersStore.builders = await BuildersService.instance.getActiveBuilders(currentUser.authentificationHeader);

       setState(() {
        _hasError = false;
        _statusMessage = "";
      });
    } 
    on PlatformException catch(e) {
      setState(() {
        _hasError = true;
        _statusMessage = "Erreur lors du rafraîchissement : ${e.message}";
      });
    }
    on Exception catch(e) {
      setState(() {
        _hasError = true;
        _statusMessage = "Erreur lors du rafraîchissement : $e";
      });
    }

  }
}