import 'package:buildup/entities/user.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/src/shared/widgets/general/bu_icon_button.dart';
import 'package:buildup/src/shared/widgets/general/bu_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuDrawerProfileInfo extends StatelessWidget {
  const BuDrawerProfileInfo({
    Key key,
    this.isMinimified = false
  }) : super(key: key);
  
  final bool isMinimified;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserStore>(
      builder: (context, userStore, child) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Theme.of(context).dividerColor
              )
            )
          ),
          child: Row(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: BuImageWidget(
                  image: userStore.user.profilePicture,
                  isCircular: true,
                ),
              ),
              if (!isMinimified) ...{
                const SizedBox(width: 15,),
                Expanded(
                  child: _buildDescription(context, userStore),
                ),
                // ignore: equal_elements_in_set
                const SizedBox(width: 15,),
                BuIconButton(
                  backgroundColor: Colors.white,
                  iconSize: 24,
                  icon: Icons.logout,
                  onPressed: () => _logout(userStore),
                )
              }
            ],
          ),
        );
      },
    );
  }

  Widget _buildDescription(BuildContext context, UserStore userStore) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(userStore.user.fullName, style: Theme.of(context).textTheme.headline6),
        const SizedBox(height: 2,),
        Text(UserRoles.detailled[userStore.user.role], style: const TextStyle(fontSize: 12, color: Color(0xff8f9bb3)),)
      ],
    );
  }

  Future _logout(UserStore userStore) async {
    await userStore.logout();
  }
}