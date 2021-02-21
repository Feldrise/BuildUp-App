import 'package:buildup/entities/meeting_report.dart';
import 'package:buildup/src/pages/meeting_reports_page/dialogs/meeting_report_summary_dialog.dart';
import 'package:buildup/src/shared/widgets/general/bu_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MeetingReportButton extends StatelessWidget {
  const MeetingReportButton({Key key, @required this.meetingReport}) : super(key: key);

  final MeetingReport meetingReport;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openSummary(context),
      child: BuCard(
        child: Row(
          children: [
            Expanded(
              child: Text("Rapport du  ${DateFormat('dd/MM/yyyy').format(meetingReport.date)}"),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.arrow_forward_ios, size: 10,)
          ],
        ),
      ),
    );
  }

  Future _openSummary(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (context) => MeetingReportSummaryDialog(meetingReport: meetingReport)
    );
  }
}