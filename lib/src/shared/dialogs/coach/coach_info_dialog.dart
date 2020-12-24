
import 'package:buildup/entities/coach.dart';
import 'package:buildup/src/shared/dialogs/dialogs.dart';
import 'package:buildup/src/shared/widgets/general/bu_appbar.dart';
import 'package:buildup/src/shared/widgets/general/bu_button.dart';
import 'package:buildup/src/shared/widgets/general/bu_card.dart';
import 'package:buildup/src/shared/widgets/general/bu_status_message.dart';
import 'package:buildup/src/shared/widgets/inputs/bu_dropdown.dart';
import 'package:buildup/src/shared/widgets/inputs/bu_image_picker.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CoachInfoDialog extends StatefulWidget {
  const CoachInfoDialog({
    Key key,
    @required this.coach,
    @required this.onSaveInfo
  }) : super(key: key);

  final Coach coach;

  final Function(Coach) onSaveInfo;

  @override
  _CoachInfoDialogState createState() => _CoachInfoDialogState();
}

class _CoachInfoDialogState extends State<CoachInfoDialog> {
  bool _hasError = false;
  String _statusMessage = "";

  String _currentStep;

  @override
  void initState() {
    super.initState();

    _currentStep = widget.coach.step;
  }

  @override
  void didUpdateWidget(covariant CoachInfoDialog oldWidget) {
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
                child: SingleChildScrollView(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth > 822) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _buildForm(),
                        );
                      }

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: _buildForm(),
                      );
                    },
                  ),
                )
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

  List<Widget> _buildForm() {
    return [
      Flexible(
        flex: 3,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 348),
          child: BuImagePicker(image: widget.coach.coachCard,),
        ),
      ),
      const SizedBox(width: 30, height: 30,),
      Flexible(
        flex: 7,
        child:Padding(
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
      )
    ];
  }

  void _cancel() {
    Navigator.of(context).pop();
  }

  Future _save() async {
    widget.coach.step = _currentStep;
      
    final GlobalKey<State> keyLoader = GlobalKey<State>();
    Dialogs.showLoadingDialog(context, keyLoader, "Mise à jour des informations..."); 

    try {
      await widget.onSaveInfo(widget.coach);

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