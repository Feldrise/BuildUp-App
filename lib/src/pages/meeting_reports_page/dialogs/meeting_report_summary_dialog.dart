
import 'package:buildup/entities/meeting_report.dart';
import 'package:buildup/src/shared/dialogs/bu_modal_dialog.dart';
import 'package:buildup/src/shared/widgets/general/bu_button.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MeetingReportSummaryDialog extends StatelessWidget {
  const MeetingReportSummaryDialog({Key? key, required this.meetingReport}) : super(key: key); 

  final MeetingReport meetingReport;

  @override
  Widget build(BuildContext context) {
    return BuModalDialog(
      title: "Rapport du  ${DateFormat('dd/MM/yyyy').format(meetingReport.date)}", 
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDescription(context),
        ],
      ), 
      actions: _buildButtons(context)
    );
  }

  List<Widget> _buildButtons(BuildContext context) {
    return [
      Container(),
      BuButton(
        text: "Valider",
        onPressed: () => Navigator.pop(context)
      )
    ];
  }

  Widget _buildDescription(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildBigInfo("Objectis de l’entretien", meetingReport.objectif),
        _buildBigInfo("Evolutions constatées", meetingReport.evolution),
        _buildBigInfo("Perspectives avant le prochain entretien", meetingReport.whatsNext),
        _buildBigInfo("Commentaires", meetingReport.comments),
        RichText(
          text: TextSpan(
            text: "Date prévue pour le prochain entretien : ",
            style: Theme.of(context).textTheme.bodyText2!.merge(const TextStyle(fontWeight: FontWeight.bold)),
            children: <TextSpan>[
              TextSpan(
                text: DateFormat('dd/MM/yyyy').format(meetingReport.nextMeetingDate),
                style: Theme.of(context).textTheme.bodyText2)
            ],
          ),
        )
      ],     
    );
  }

  Widget _buildBigInfo(String title, String info) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: colorPrimary),),
            const SizedBox(height: 7,),
            Text(info)
          ],  
        ),
      ),
    );
  } 
}