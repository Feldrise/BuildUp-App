import 'package:buildup/services/coachs_services.dart';
import 'package:buildup/src/pages/administration/admin_active_pages/admin_active_coachs_page/widgets/admin_active_coach_card.dart';
import 'package:buildup/src/providers/active_coachs_store.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/src/shared/widgets/general/bu_status_message.dart';
import 'package:buildup/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AdminActiveCoachsPage extends StatefulWidget {
  const AdminActiveCoachsPage({Key? key,}) : super(key: key);

  @override
  _AdminActiveCoachsPageState createState() => _AdminActiveCoachsPageState();
}

class _AdminActiveCoachsPageState extends State<AdminActiveCoachsPage> {
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
              Consumer<ActiveCoachsStore>(
                builder: (context, activeCoachsStore, child) {
                  if (!activeCoachsStore.hasData) {
                    return Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 30, horizontal: horizontalPadding),
                        child: const BuStatusMessage(
                          type: BuStatusMessageType.info,
                          message: "Il n'y a aucun coach actif pour le moment",
                        ),
                      ),
                    );
                  }

                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 30, horizontal: horizontalPadding),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return SingleChildScrollView(
                            child: Wrap(
                              spacing: 15,
                              runSpacing: 15,
                              children: [
                                for (final coach in activeCoachsStore.coachs!) 
                                  AdminActiveCoachCard(
                                    coach: coach,
                                    width: constraints.maxWidth > 500 ? 250 : constraints.maxWidth,
                                  ),
                              ],
                            ),
                          );
                        },
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
    final ActiveCoachsStore activeCoachsStore = Provider.of<ActiveCoachsStore>(context, listen: false);
    final UserStore currentUser = Provider.of<UserStore>(context, listen: false);

    try {
      activeCoachsStore.coachs = await CoachsService.instance.getActiveCoachs(currentUser.authentificationHeader);

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