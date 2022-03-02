import 'package:buildup/core/widgets/bu_card.dart';
import 'package:buildup/core/widgets/titled_card_bar.dart';
import 'package:buildup/features/users/user.dart';
import 'package:buildup/features/users/widgets/user_profile_info.dart';
import 'package:flutter/material.dart';

class UserProfileCard extends StatelessWidget {
  const UserProfileCard({
    Key? key,
    required this.user, 
    required this.isLoggedUser
  }) : super(key: key);

  final User user;
  final bool isLoggedUser;

  @override
  Widget build(BuildContext context) {
    return BuCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // The header
          TitledCardBar(
            title: "${user.firstName} ${user.lastName}",
            actionText: isLoggedUser ? "Modifier" : null,
            actionIcon: isLoggedUser ? Icons.edit : null,
            onActionClicked: isLoggedUser ? () {} : null,
          ),
          const SizedBox(height: 30,),

          // The user's info
          Flexible(
            child: UserProfileInfo(user: user),
          )
        ],
      ),
    );
  }
}