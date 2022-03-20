import 'package:buildup/core/utils/screen_utils.dart';
import 'package:buildup/core/widgets/bu_status_message.dart';
import 'package:buildup/features/authentication/authentication_graphql.dart';
import 'package:buildup/features/project/widgets/project_card.dart';
import 'package:buildup/features/users/forms/widgets/form_card.dart';
import 'package:buildup/features/users/user.dart';
import 'package:buildup/features/users/users_graphql.dart';
import 'package:buildup/features/users/widgets/user_profile_card.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({
    Key? key, 
    required this.userId,
    this.appBarTitle,
  }) : super(key: key);

  final String? userId;
  final String? appBarTitle;

  QueryOptions<Map<String, dynamic>> _loggedUserOptions() {
    return QueryOptions<Map<String, dynamic>>(
      document: gql(qGetLoggedUser)
    );
  }

  QueryOptions<Map<String, dynamic>> _userOptions() {
    return QueryOptions<Map<String, dynamic>>(
      document: gql(qGetDetailedUser),
      variables: <String, dynamic>{
        "id": userId
      },
      fetchPolicy: FetchPolicy.noCache
    );
  }

  @override
  Widget build(BuildContext context) {
    // First, we need to get the connected user
    return Scaffold(
      appBar: appBarTitle == null ? null : AppBar(
        title: Text(appBarTitle!),
      ),
      body: Query<Map<String, dynamic>>(
        options: _loggedUserOptions(),
        builder: (loggedResult, {fetchMore, refetch}) {
          if (loggedResult.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
    
          if (loggedResult.hasException) {
            return const Align(
              alignment: Alignment.topLeft,
              child: BuStatusMessage(
                message: "Nous n'arrivons pas à charger vos informations. Cette erreur ne devrait pas arriver, n'hésitez pas à nous contacter.",
              ),
            );
          }
    
          final User appUser = User.fromJson(loggedResult.data?["user"] as Map<String, dynamic>? ?? <String, dynamic>{});

          // Now we can get the actual user
          return Query<Map<String, dynamic>>(
            options: _userOptions(),
            builder: (userResult, {fetchMore, refetch}) {
              if (userResult.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
        
              if (userResult.hasException) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.all(ScreenUtils.instance.horizontalPadding),
                    child: const BuStatusMessage(
                      message: "Nous n'arrivons pas à charger les informations de l'utilisateur."
                    ),
                  ),
                );
              }

              final User user = User.fromJson(userResult.data?["user"] as Map<String, dynamic>? ?? <String, dynamic>{});
              final bool isLoggedUser = appUser.id == user.id; 
              final bool isAdmin = appUser.role == UserRoles.admin;
              final bool isCoach = appUser.role == UserRoles.coach;

              return SingleChildScrollView(
                controller: ScrollController(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtils.instance.horizontalPadding
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: ScreenUtils.instance.horizontalPadding,),
                      // The logged user
                      Flexible(
                        child: UserProfileCard(
                          user: user, 
                          refetch: refetch,
                          isLoggedUser: isLoggedUser,
                          isAdmin: isAdmin,
                        )
                      ),
                      const SizedBox(height: 30,),

                      // The project if there is one
                      if (user.builder?.project != null && (isAdmin || isCoach)) ...{
                        Flexible(
                          child: ProjectCard(
                            project: user.builder!.project!, 
                            userID: user.id!,
                            isLoggedUser: isLoggedUser,
                            isAdmin: isAdmin,
                            refetch: refetch,
                          )
                        ),
                        const SizedBox(height: 30,),
                      },

                      Flexible(
                        child: FormCard(user: user),
                      ),

                      SizedBox(height: ScreenUtils.instance.horizontalPadding,),
                      
                    ],
                  ),
                ),
              );
            },
          );
    
        },
      ),
    );
  }
}