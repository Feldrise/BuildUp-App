import 'package:buildup/entities/coach.dart';
import 'package:buildup/src/shared/dialogs/bu_modal_dialog.dart';
import 'package:buildup/src/shared/widgets/general/bu_button.dart';
import 'package:buildup/src/shared/widgets/inputs/bu_dropdown.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';

class AdminUpdateCandidatingCoachDialog extends StatefulWidget {
  const AdminUpdateCandidatingCoachDialog({Key key, @required this.coach}) : super(key: key);

  final Coach coach;

  @override
  _AdminUpdateCandidatingCoachDialogState createState() => _AdminUpdateCandidatingCoachDialogState();
}

class _AdminUpdateCandidatingCoachDialogState extends State<AdminUpdateCandidatingCoachDialog> {
  String _currentStatus;
  String _currentStep;

  @override
  void initState() {
    super.initState();

    _currentStatus = widget.coach.status;
    _currentStep = widget.coach.step;
  }

  @override
  void didUpdateWidget(covariant AdminUpdateCandidatingCoachDialog oldWidget) {
    super.didUpdateWidget(oldWidget);

    _currentStatus = widget.coach.status;
    _currentStep = widget.coach.step;
  }

  @override
  Widget build(BuildContext context) {
    return BuModalDialog(
      title: "Modifier la candidature",
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDescription(),
          const SizedBox(height: 30,),
          if (MediaQuery.of(context).size.width > 476) Row(
            children: _buildDropdowns(context),
          ) else Column(
            mainAxisSize: MainAxisSize.min,
            children: _buildDropdowns(context),
          ),
        ],
      ),
      actions: _buildButtons(context),
    );
  }

  List<Widget> _buildDropdowns(BuildContext context) {
    return [
      Flexible(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("état".toUpperCase(), style: const TextStyle(fontSize: 14, color: Color(0xff919191)),),
            const SizedBox(height: 10,),
            BuDropdown<String>(
              items: CoachStatus.detailled,
              currentValue: _currentStatus,
              onChanged: (newValue) {
                widget.coach.status = newValue;
                setState(() {
                  _currentStatus = newValue;
                });
              },
            )
          ],
        ),
      ),
      const SizedBox(height: 15, width: 50,),
      Flexible(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("étape".toUpperCase(), style: const TextStyle(fontSize: 14, color: Color(0xff919191)),),
            const SizedBox(height: 10,),
            BuDropdown<String>(
              items: CoachSteps.detailled,
              currentValue: _currentStep,
              onChanged: (newValue) {
                widget.coach.step = newValue;
                setState(() {
                  _currentStep = newValue;
                });
              },
            )
          ],
        ),
      )
    ];
  }

  List<Widget> _buildButtons(BuildContext context) {
    return [
      BuButton(
        buttonType: BuButtonType.secondary,
        text: "Annuler",
        onPressed: () => Navigator.pop(context, false),
        isBig: true,
      ),
      BuButton(
        text: "Valider",
        onPressed: () => Navigator.pop(context, true),
        isBig: true,
      )
    ];
  }

  Widget _buildDescription() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: 240,
      decoration: BoxDecoration(
        color: colorScaffoldGrey,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Nom :", style: TextStyle(fontWeight: FontWeight.w500),),
          const SizedBox(height: 5,),
          Text(widget.coach.associatedUser.fullName),
          const SizedBox(height: 8,),
          const Text("Situation :", style: TextStyle(fontWeight: FontWeight.w500),),
          const SizedBox(height: 5,),
          Text(widget.coach.situation),
        ],        
      ),
    );
  } 
}