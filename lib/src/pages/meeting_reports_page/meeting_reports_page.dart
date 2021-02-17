
import 'package:buildup/entities/builder.dart';
import 'package:buildup/entities/meeting_report.dart';
import 'package:buildup/entities/user.dart';
import 'package:buildup/services/builders_service.dart';
import 'package:buildup/src/pages/meeting_reports_page/dialogs/create_meeting_report_dialog.dart';
import 'package:buildup/src/pages/meeting_reports_page/widgets/meeting_report_button.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/src/shared/dialogs/dialogs.dart';
import 'package:buildup/src/shared/widgets/general/bu_appbar.dart';
import 'package:buildup/src/shared/widgets/general/bu_status_message.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MeetingRepportsPage extends StatefulWidget {
  const MeetingRepportsPage({Key key, @required this.builder}) : super(key: key);
  
  final BuBuilder builder;

  @override
  _MeetingRepportsPageState createState() => _MeetingRepportsPageState();
}

class _MeetingRepportsPageState extends State<MeetingRepportsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScaffoldGrey,
      appBar: BuAppBar(
        title: Text("Rapports de ${widget.builder.associatedUser.fullName}", style: Theme.of(context).textTheme.headline5,),
      ),
      body: widget.builder.associatedMeetingReports.isEmpty 
      ? const Center(child: BuStatusMessage(message: "Vous n'avez pas encore de rapport...", type: BuStatusMessageType.info,),) 
      : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                for (final meetingReport in widget.builder.associatedMeetingReports) 
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 250),
                    child: MeetingReportButton(meetingReport: meetingReport,),
                  )
              ],
            )
          ],
        ),
      ),
      floatingActionButton: Provider.of<UserStore>(context).user.role != UserRoles.coach ? null :
        FloatingActionButton(
          backgroundColor: colorPrimary,
          onPressed: _createMeetingReport,
          child: const Icon(Icons.add, color: Colors.white,),
        ),
    );
  }

  Future _createMeetingReport() async {
    final MeetingReport toCreate = await showDialog(
      context: context,
      builder: (context) => CreateMeetingReportDialog()
    );

    if (toCreate == null) {
      return;
    }

    final GlobalKey<State> keyLoader = GlobalKey<State>();
    Dialogs.showLoadingDialog(context, keyLoader, "Création du rapport en cours..."); 

    try {
      final String authorization = Provider.of<UserStore>(context, listen: false).user.authentificationHeader;
      toCreate.id = await BuildersService.instance.createMeetingReport(authorization, widget.builder.id, toCreate);

      setState(() {
        widget.builder.associatedMeetingReports.add(toCreate);
      });
    } on Exception {
      // TODO: proper error message
      Navigator.of(keyLoader.currentContext,rootNavigator: true).pop(); 
      return;
    }

    Navigator.of(keyLoader.currentContext,rootNavigator: true).pop();
  }
}