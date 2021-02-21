import 'package:buildup/entities/notification/coach_notification.dart';
import 'package:buildup/src/shared/widgets/general/bu_card.dart';
import 'package:flutter/material.dart';

class CoachNotificationCard extends StatelessWidget {
  const CoachNotificationCard({
    Key key, 
    @required this.notification,
    @required this.onMarkedAsRead,
  }) : super(key: key);
  
  final CoachNotification notification;
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