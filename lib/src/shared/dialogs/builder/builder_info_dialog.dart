import 'package:buildup/entities/builder.dart';
import 'package:buildup/entities/coach.dart';
import 'package:buildup/entities/ntf_referent.dart';
import 'package:buildup/src/providers/active_coachs_store.dart';
import 'package:buildup/src/providers/ntf_referents_store.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/src/shared/dialogs/dialogs.dart';
import 'package:buildup/src/shared/widgets/general/bu_appbar.dart';
import 'package:buildup/src/shared/widgets/general/bu_button.dart';
import 'package:buildup/src/shared/widgets/general/bu_card.dart';
import 'package:buildup/src/shared/widgets/inputs/bu_date_form_field.dart';
import 'package:buildup/src/shared/widgets/inputs/bu_dropdown.dart';
import 'package:buildup/src/shared/widgets/inputs/bu_image_picker.dart';
import 'package:buildup/src/shared/widgets/general/bu_status_message.dart';
import 'package:buildup/utils/colors.dart';
import 'package:buildup/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class BuilderInfoDialog extends StatefulWidget {
  const BuilderInfoDialog({
    Key key, 
    @required this.builder,
    @required this.onSaveInfo
  }) : super(key: key);

  final BuBuilder builder;

  final Function(BuBuilder) onSaveInfo;

  @override
  _BuilderInfoDialogState createState() => _BuilderInfoDialogState();
}

class _BuilderInfoDialogState extends State<BuilderInfoDialog> {
  String _statusMessage = "";
  bool _hasError = false;

  String _assignedCoach;
  String _assignedReferent;
  String _currentStep; 

  @override
  void initState() {
    super.initState();

    _assignedCoach = widget.builder.associatedCoach != null ? widget.builder.associatedCoach.id : "";
    _assignedReferent = widget.builder.associatedNtfReferent != null ? widget.builder.associatedNtfReferent.id : "";
    _currentStep = widget.builder.step;
  }
  @override
  Widget build(BuildContext context) {
    final horizontalPadding = ScreenUtils.instance.horizontalPadding;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: horizontalPadding),
      color: colorScaffoldGrey,
      child: BuCard(
        padding: EdgeInsets.zero,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: BuAppBar(
            backgroundColor: Colors.transparent,
            title: Text("Modifier les informations Builder de ${widget.builder.associatedUser.fullName}", style: Theme.of(context).textTheme.headline5),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: horizontalPadding),
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
                const SizedBox(height: 30,),
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
              ]
            )
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
          child: BuImagePicker(image: widget.builder.builderCard,),
        ),
      ),
      const SizedBox(width: 30, height: 30,),
      Flexible(
        flex: 7,
        child:_buildInfoFields() ,
      )
    ];
  }

  Widget _buildInfoFields() {
    final String authorizaton = Provider.of<UserStore>(context).authentificationHeader;

    return LayoutBuilder(
      builder: (context, constraints) {
        double width = (constraints.maxWidth - 15) / 2;
        width = width < 200 ? (constraints.maxWidth) : width;

        return Wrap(
          spacing: 15,
          runSpacing: 15,
          children: [
            // Coachs
            SizedBox(
              width: width,
              child: BuDropdown<String>(
                label: "Coach assigné",
                currentValue: _assignedCoach,
                items: <String, String> {
                  "": "Pas de Coach",
                  for (Coach coach in Provider.of<ActiveCoachsStore>(context).coachs)
                    coach.id: coach.associatedUser.fullName
                },
                onChanged: (value) {
                  setState(() {
                    _assignedCoach = value;
                  });
                },
              )
            ),

            // Step
            SizedBox(
              width: width,
              child: BuDropdown<String>(
                label: "Etape actuelle",
                currentValue: _currentStep,
                items: <String, String>{
                  BuilderSteps.preselected: BuilderSteps.detailled[BuilderSteps.preselected],
                  BuilderSteps.adminMeeting: BuilderSteps.detailled[BuilderSteps.adminMeeting],
                  BuilderSteps.coachMeeting: BuilderSteps.detailled[BuilderSteps.coachMeeting],
                  BuilderSteps.active: BuilderSteps.detailled[BuilderSteps.active],
                  BuilderSteps.finished: BuilderSteps.detailled[BuilderSteps.finished],
                  BuilderSteps.abandoned: BuilderSteps.detailled[BuilderSteps.abandoned]
                },
                onChanged: (value) {
                  setState(() {
                    _currentStep = value;
                  });
                },
              )
            ),

            // Referent
            SizedBox(
              width: width,
              child: FutureBuilder(
                future: Provider.of<NtfReferentsStore>(context).ntfReferents(authorizaton),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Center(child: Text("Erreur lors de la récupération des référents..."),);
                  }

                  final List<NtfReferent> ntfReferents = snapshot.data as List<NtfReferent>;

                  return BuDropdown<String>(
                    label: "Référent assigné",
                    currentValue: _assignedReferent,
                    items: <String, String> {
                      "": "Pas de référent",
                      for (NtfReferent referent in ntfReferents)
                        referent.id: referent.name
                    },
                    onChanged: (value) {
                      setState(() {
                        _assignedReferent = value;
                      });
                    },
                  );
                },
              )
            ),

            // Program end date
            SizedBox(
              width: width,
              child: BuDateFormField(
                context: context,
                firstDate: DateTime.fromMillisecondsSinceEpoch(0),
                lastDate: DateTime.now().add(const Duration(days: 1000)),
                initialValue: widget.builder.programEndDate,
                label: "Fin du programme",
                validator: (value) {
                  if (value == null) {
                    return "Une date est obligatoire";
                  }

                  return null;
                },
                onChanged: (value) {
                  widget.builder.programEndDate = value;
                },
              ),
            ),
          ]
        );
      }
    );
  }
  
  void _cancel() {
    Navigator.of(context).pop();
  }

  Future _save() async {
    final String authorization = Provider.of<UserStore>(context, listen: false).authentificationHeader;

    final List<Coach> coachs = Provider.of<ActiveCoachsStore>(context, listen: false).coachs;
    final List<NtfReferent> ntfReferents = await Provider.of<NtfReferentsStore>(context, listen: false).ntfReferents(authorization);
    
    if (_assignedCoach.isEmpty) {
      widget.builder.associatedCoach = null;
    } 
    else {
      for (final coach in coachs) {
        if (coach.id == _assignedCoach) {
          widget.builder.associatedCoach = coach;
          break;
        }
      }
    }

    if (_assignedReferent.isEmpty) {
      widget.builder.associatedNtfReferent = null;
    }
    else {
      for (final referent in ntfReferents) {
        if (referent.id == _assignedReferent) {
          widget.builder.associatedNtfReferent = referent;
          break;
        }
      }
    }
    
    widget.builder.step = _currentStep;

    final GlobalKey<State> keyLoader = GlobalKey<State>();
    Dialogs.showLoadingDialog(context, keyLoader, "Mise à jour des informations..."); 

    try {
      await widget.onSaveInfo(widget.builder);

      setState(() {
        _hasError = false;
        _statusMessage = "Les informations ont bien étés mis à jour.";
      });
    } on PlatformException catch(e) {
      setState(() {
        _hasError = true;
        _statusMessage = "Erreur lors de la mise à jour des informations : ${e.message}";
      });
    } on Exception catch(e) {
      setState(() {
        _hasError = true;
        _statusMessage = "Erreur lors de la mise à jour des informations : $e";
      });
    }

    Navigator.of(keyLoader.currentContext,rootNavigator: true).pop(); 
  }
}