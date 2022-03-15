import 'package:buildup/core/widgets/bu_card.dart';
import 'package:buildup/core/widgets/titled_card_bar.dart';
import 'package:buildup/features/users/user.dart';
import 'package:buildup/features/users/widgets/user_profile_card_form.dart';
import 'package:buildup/features/users/widgets/user_profile_info.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UserProfileCard extends StatefulWidget {
  const UserProfileCard({
    Key? key,
    required this.user, 
    required this.isLoggedUser,
    required this.isAdmin,
    required this.refetch,
  }) : super(key: key);

  final User user;
  final bool isLoggedUser;
  final bool isAdmin;
                
  final Future<QueryResult<Map<String, dynamic>>?> Function()? refetch;

  @override
  State<UserProfileCard> createState() => _UserProfileCardState();
}

class _UserProfileCardState extends State<UserProfileCard> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return BuCard(
      child: Builder(
        builder: (context) {
          if (_currentPage == 1) {
            return UserProfileCardForm(
              user: widget.user,
              onPop: () => _animateScroll(0),
              refetch: widget.refetch,
            );
          }

          // The info card
          return Column(
            mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // The header
              TitledCardBar(
                title: "${widget.user.firstName} ${widget.user.lastName}",
                actionText: (widget.isLoggedUser || widget.isAdmin) ? "Modifier" : null,
                actionIcon: (widget.isLoggedUser || widget.isAdmin) ? Icons.edit : null,
                onActionClicked: (widget.isLoggedUser || widget.isAdmin) ? () async {
                    _animateScroll(1);
                } : null,
              ),
              const SizedBox(height: 30,),
        
              // The user's info
              Flexible(
                child: UserProfileInfo(user: widget.user),
              )
            ]
          );
        }
      )
    );
  }

  Future _animateScroll(int page) async {
    setState(() {
      _currentPage = page;
    });
  }
}