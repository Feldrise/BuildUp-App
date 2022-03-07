import 'package:buildup/core/widgets/bu_status_message.dart';
import 'package:buildup/core/widgets/dialogs/closable_dialog.dart';
import 'package:buildup/features/project/widgets/project_info.dart';
import 'package:buildup/features/users/user.dart';
import 'package:buildup/features/users/users_graphql.dart';
import 'package:buildup/features/users/widgets/user_profile_info.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UserProfilDialog extends StatelessWidget {
  const UserProfilDialog({
    Key? key,
    required this.userId,
    required this.dialogTitle,
  }) : super(key: key);
  
  final String userId;
  final String dialogTitle;

  QueryOptions<Map<String, dynamic>> _userOptions() {
    return QueryOptions<Map<String, dynamic>>(
      document: gql(qGetDetailedUser),
      variables: <String, dynamic>{
        "id": userId
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClosableDialog(
      title: dialogTitle,
      child: Query<Map<String, dynamic>>(
        options: _userOptions(),
        builder: (userResult, {fetchMore, refetch}) {
          if (userResult.isLoading) {
            return const Center(child: CircularProgressIndicator(),);
          }

          if (userResult.hasException) {
            return const BuStatusMessage(
              message: "Impossible de charger les informations de l'utilisateur...",
            );
          }

          final User user = User.fromJson(userResult.data?["user"] as Map<String, dynamic>? ?? <String, dynamic>{});

          return Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Profile
              _buildTitle(context, "Profil"),
              const SizedBox(height: 12,),
              UserProfileInfo(user: user, showProfilePicture: false,),
              const SizedBox(height: 32,),

              // Project (if any)
              if (user.builder?.project != null) ...{
                _buildTitle(context, "Projet"),
                const SizedBox(height: 12,),
                ProjectInfo(project: user.builder!.project!,),
                const SizedBox(height: 32,),
              },

              // Form
              _buildTitle(context, "Réponses au formulaire")
            ],
          );
        },
      ),
    );
  }

  Widget _buildTitle(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 24,
        fontWeight: FontWeight.w700
      )
    );
  }
}