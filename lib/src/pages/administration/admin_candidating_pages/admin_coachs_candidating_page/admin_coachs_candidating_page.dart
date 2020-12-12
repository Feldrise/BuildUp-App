import 'package:buildup/services/coachs_services.dart';
import 'package:buildup/src/pages/administration/admin_candidating_pages/admin_coachs_candidating_page/widgets/admin_candidating_coachs_card.dart';
import 'package:buildup/src/providers/candidating_coachs_store.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/src/shared/widgets/bu_status_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AdminCoachsCandidatingPage extends StatefulWidget {
  const AdminCoachsCandidatingPage({Key key}) : super(key: key);

  @override
  _AdminCoachsCandidatingPageState createState() => _AdminCoachsCandidatingPageState();
}

class _AdminCoachsCandidatingPageState extends State<AdminCoachsCandidatingPage> {
  bool _hasError = false;
  String _statusMessage = "";

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _refresh(context),
      child: Stack(
        children: [
          ListView(), // Here to make the RefreshIndicator working
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_hasError)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                  child: BuStatusMessage(
                    title: "Erreur",
                    message: _statusMessage,
                  ),
                ),
              Consumer<CandidatingCoachsStore>(
                builder: (context, candidatingCoachsStore, child) {
                  if (!candidatingCoachsStore.hasData) {
                    return const Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: BuStatusMessage(
                          type: BuStatusMessageType.info,
                          message: "Il n'y a aucun coach candidatant pour le moment",
                        ),
                      ),
                    );
                  }
                  
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (final coach in candidatingCoachsStore.coachs) ...{
                          AdminCandidatingCoachCard(coach: coach,),
                          const SizedBox(height: 15,)
                        }
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _refresh(BuildContext context) async {
    final CandidatingCoachsStore candidatingBuilderStore = Provider.of<CandidatingCoachsStore>(context, listen: false);
    final UserStore currentUser = Provider.of<UserStore>(context, listen: false);

    try {
      candidatingBuilderStore.coachs = await CoachsService.instance.getCandidatingCoach(currentUser.authentificationHeader);

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