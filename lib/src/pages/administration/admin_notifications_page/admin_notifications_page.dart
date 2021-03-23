import 'package:buildup/services/users_service.dart';
import 'package:buildup/src/pages/administration/admin_notifications_page/widgets/send_notification_card.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/src/shared/widgets/general/bu_status_message.dart';
import 'package:buildup/utils/colors.dart';
import 'package:buildup/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AdminNotificationsPage extends StatefulWidget {
  @override
  _AdminNotificationsPageState createState() => _AdminNotificationsPageState();
}

class _AdminNotificationsPageState extends State<AdminNotificationsPage> {
  bool _hasError = false;
  String _statusMessage = "";

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = ScreenUtils.instance.horizontalPadding;
    
    return Scaffold(
      backgroundColor: colorScaffoldGrey,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: horizontalPadding),
        child: SingleChildScrollView(
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
              SendNotificationCard(
                onSendNotification: _sendNotifiction,
              ),
            ],
          ),
        ),
      ),

    );   
  }

  Future _sendNotifiction(String content) async {
    final String authorization = Provider.of<UserStore>(context, listen: false).authentificationHeader;

    try {
      await UsersService.instance.notifyAll(authorization, content);

      setState(() {
        _hasError = false;
        _statusMessage = "La notification a bien été envoyée";
      });
    }
    on PlatformException catch(e) {
      setState(() {
        _hasError = true;
        _statusMessage = e.message;
      });
    }
    on Exception catch(e) {
      setState(() {
        _hasError = true;
        _statusMessage = "Faile to send notifications: $e";
      });
    }
  }
}