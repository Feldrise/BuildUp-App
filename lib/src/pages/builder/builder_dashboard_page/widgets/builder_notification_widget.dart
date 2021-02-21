import 'package:buildup/entities/notification/builder_notification.dart';
import 'package:buildup/src/pages/builder/builder_dashboard_page/widgets/builder_notification_card.dart';
import 'package:buildup/src/providers/builder_store.dart';
import 'package:buildup/src/shared/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuilderNotificationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BuilderStore>(
      builder: (context, builderStore, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Actualités", style: Theme.of(context).textTheme.headline4),
            const SizedBox(height: 16,),
            if (builderStore.builder.associatedNotifications?.isEmpty) 
              const Text("Vous n'avez pas de nouvelle notification")
            else 
              for (final notification in builderStore.builder.associatedNotifications)
                BuilderNotificationCard(
                  notification: notification, 
                  onMarkedAsRead: () => _markNotificationAsRead(context, builderStore, notification)
                )
          ],
        );
      },
    );
  }

  Future _markNotificationAsRead(BuildContext context, BuilderStore builderStore, BuilderNotification notification) async {
    final GlobalKey<State> keyLoader = GlobalKey<State>();
    Dialogs.showLoadingDialog(context, keyLoader, "Mise à jour..."); 

    try {
      final String authorization = builderStore.builder.associatedUser.authentificationHeader;

      await builderStore.markNotificationAsRead(authorization, notification);
    } on Exception {
      // TODO: proper error message
      Navigator.of(keyLoader.currentContext,rootNavigator: true).pop(); 
      return;
    }

    Navigator.of(keyLoader.currentContext,rootNavigator: true).pop();
  }
}