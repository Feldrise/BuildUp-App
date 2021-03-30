
import 'package:buildup/entities/notification/builder_notification.dart';
import 'package:buildup/src/shared/widgets/general/bu_card.dart';
import 'package:flutter/material.dart';

class BuilderNotificationCard extends StatelessWidget {
  const BuilderNotificationCard({
    Key? key, 
    required this.notification,
    required this.onMarkedAsRead,
  }) : super(key: key);
  
  final BuilderNotification notification;
  final Function() onMarkedAsRead;

  @override
  Widget build(BuildContext context) {
    return BuCard(
      child: Row(
        children: [
          Expanded(
            child: Text(notification.content),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: onMarkedAsRead,
            child: const Icon(Icons.visibility, size: 18,),
          )
        ],
      )
    );
  }
}