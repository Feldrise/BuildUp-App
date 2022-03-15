import 'package:buildup/core/utils/screen_utils.dart';
import 'package:buildup/core/widgets/bu_status_message.dart';
import 'package:buildup/features/project/widgets/project_card.dart';
import 'package:buildup/features/users/user.dart';
import 'package:buildup/features/users/users_graphql.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({Key? key}) : super(key: key);

  QueryOptions<Map<String, dynamic>> _userOptions() {
    return QueryOptions<Map<String, dynamic>>(
      document: gql(qGetDetailedUser),
      fetchPolicy: FetchPolicy.noCache
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: ScreenUtils.instance.horizontalPadding,
          right: ScreenUtils.instance.horizontalPadding,
          top: 30
        ),
        child: Query<Map<String, dynamic>>(
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
                    message: "Nous n'arrivons pas à charger les informations du projet."
                  ),
                ),
              );
            }

            final User user = User.fromJson(userResult.data?["user"] as Map<String, dynamic>? ?? <String, dynamic>{});

            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    child: ProjectCard(
                      project: user.builder!.project!, 
                      userID: user.id!,
                      isLoggedUser: true,
                      isAdmin: false,
                      refetch: refetch,
                    )
                  ),
                  const SizedBox(height: 30,),
                ],
              ),
            );
          }
        )
      ),
    );
  }
}