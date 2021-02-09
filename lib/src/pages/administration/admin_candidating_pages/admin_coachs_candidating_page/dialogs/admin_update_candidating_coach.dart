import 'package:buildup/entities/coach.dart';
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
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 50),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: const Border(
            top: BorderSide(
              width: 4,
              color: colorPrimary
            )
          )
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text("Modifier la candidature", style: Theme.of(context).textTheme.headline4,)
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context, false),
                  child: const Icon(Icons.close, size: 28,),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            const Divider(),
            const SizedBox(height: 30,),
            buildDescription(),
            const SizedBox(height: 30,),
            if (MediaQuery.of(context).size.width > 476) Row(
              children: buildDropdowns(context),
            ) else Column(
              mainAxisSize: MainAxisSize.min,
              children: buildDropdowns(context),
            ),
            const SizedBox(height: 40,),
            if (MediaQuery.of(context).size.width > 476) Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: buildButtons(context),
            ) else Column(
              mainAxisSize: MainAxisSize.min,
              children: buildButtons(context),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> buildDropdowns(BuildContext context) {
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

  List<Widget> buildButtons(BuildContext context) {
    return [
      BuButton(
        buttonType: BuButtonType.secondary,
        text: "Annuler",
        onPressed: () => Navigator.pop(context, false),
        isBig: true,
      ),
      const SizedBox(width: 8.0, height: 8.0,),
      BuButton(
        text: "Valider",
        onPressed: () => Navigator.pop(context, true),
        isBig: true,
      )
    ];
  }

  Widget buildDescription() {
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