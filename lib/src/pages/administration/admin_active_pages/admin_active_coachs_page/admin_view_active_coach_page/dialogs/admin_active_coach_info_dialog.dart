import 'package:buildup/entities/coach.dart';
import 'package:buildup/src/providers/active_coachs_store.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/src/shared/dialogs/dialogs.dart';
import 'package:buildup/src/shared/widgets/general/bu_appbar.dart';
import 'package:buildup/src/shared/widgets/general/bu_button.dart';
import 'package:buildup/src/shared/widgets/general/bu_card.dart';
import 'package:buildup/src/shared/widgets/inputs/bu_dropdown.dart';
import 'package:buildup/src/shared/widgets/general/bu_status_message.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AdminActiveCoachInfoDialog extends StatefulWidget {
  final Coach coach;

  const AdminActiveCoachInfoDialog({Key key, this.coach}) : super(key: key);

  @override
  _AdminActiveCoachInfoDialogState createState() => _AdminActiveCoachInfoDialogState();
}

class _AdminActiveCoachInfoDialogState extends State<AdminActiveCoachInfoDialog> {
  bool _hasError = false;
  String _statusMessage = "";

  String _currentStep;

  @override
  void initState() {
    super.initState();

    _currentStep = widget.coach.step;
  }

  @override
  void didUpdateWidget(covariant AdminActiveCoachInfoDialog oldWidget) {
    super.didUpdateWidget(oldWidget);

    _currentStep = widget.coach.step;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      color: colorScaffoldGrey,
      child: BuCard(
        padding: EdgeInsets.zero,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: BuAppBar(
            backgroundColor: Colors.transparent,
            title: Text("Modifier les information Coach de ${widget.coach.associatedUser.fullName}", style: Theme.of(context).textTheme.headline5),
          ),
          body: Column(
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
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("étape actuelle".toUpperCase(), style: const TextStyle(fontSize: 14, color: Color(0xff919191)),),
                      const SizedBox(height: 10,),
                      SizedBox(
                        height: 200,
                        child: BuDropdown<String>(
                          items: <String, String>{
                            CoachSteps.preselected: CoachSteps.detailled[CoachSteps.preselected],
                            CoachSteps.meeting: CoachSteps.detailled[CoachSteps.meeting],
                            CoachSteps.active: CoachSteps.detailled[CoachSteps.active],
                            CoachSteps.stopped: CoachSteps.detailled[CoachSteps.stopped],
                          },
                          currentValue: _currentStep,
                          onChanged: (newValue) {
                            widget.coach.step = newValue;
                            setState(() {
                              _currentStep = newValue;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              Wrap(
                alignment: WrapAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 200,
                      child: BuButton(
                        buttonType: BuButtonType.secondary,
                        text: "Annuler", 
                        onPressed: _cancel
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 200,
                      child: BuButton(
                        icon: Icons.edit,
                        text: "Modifier",
                        onPressed: _save,
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        )
      )
    );
  }

  void _cancel() {
    Navigator.of(context).pop();
  }

  Future _save() async {
    widget.coach.step = _currentStep;
      
    final GlobalKey<State> keyLoader = GlobalKey<State>();
    Dialogs.showLoadingDialog(context, keyLoader, "Mise à jour des informations..."); 

    try {
      final String authorization = Provider.of<UserStore>(context, listen: false).authentificationHeader;

      await Provider.of<ActiveCoachsStore>(context, listen: false).updateCoach(authorization, widget.coach);

      setState(() {
        _hasError = false;
        _statusMessage = "Les informations ont bien étés mis à jour.";
      });
    } on PlatformException catch(e) {
      setState(() {
        _hasError = true;
        _statusMessage = "Erreur lors de la mise à jour des infos : ${e.message}";
      });
    } on Exception catch(e) {
      setState(() {
        _hasError = true;
        _statusMessage = "Erreur lors de la mise à jour des infos : $e";
      });
    }

    Navigator.of(keyLoader.currentContext,rootNavigator: true).pop(); 
  }
}