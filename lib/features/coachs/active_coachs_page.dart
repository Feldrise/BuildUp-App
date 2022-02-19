import 'package:buildup/core/utils/screen_utils.dart';
import 'package:buildup/core/widgets/bu_status_message.dart';
import 'package:buildup/features/authentication/user.dart';
import 'package:buildup/features/coachs/coach_graphql.dart';
import 'package:buildup/features/coachs/widgets/coach_card.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ActiveCoachsPage extends StatelessWidget {
  const ActiveCoachsPage({Key? key}) : super(key: key);

  QueryOptions<Map<String, dynamic>> _queryOptions() {
    return QueryOptions(
      document: gql(qActiveCoachs)
    );
  } 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: ScreenUtils.instance.horizontalPadding,
        left: ScreenUtils.instance.horizontalPadding,
        right: ScreenUtils.instance.horizontalPadding
      ),
      child: Query(
        options: _queryOptions(),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator(),);
          }

          if (result.hasException) {
            return const BuStatusMessage(
              title: "Erreur de chargement",
              message: "Nous ne parvenons pas à charger la liste des coachs actifs... Si ce problème persite, n'hésitez pas à nous contacter.",
            );
          }

          final List mapsCoachs = result.data!["users"] as List;
          final List<User> coachs = [];
          for (final map in mapsCoachs) {
            coachs.add(User.fromJson(map as Map<String, dynamic>));
          }

          if (coachs.isEmpty) return _buildEmptyInfo(context);

          return GridView(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 255,
              childAspectRatio: 8/10,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16
            ),
            shrinkWrap: true,
            children: [
                for (final coach in coachs)
                  CoachCard(coach: coach)
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.no_accounts, 
          size: 92,
          color: Theme.of(context).textTheme.caption!.color
        ),
        const SizedBox(height: 8,),
        Text(
          "Il n'y a aucun coach actif pour le moment",
          style: TextStyle(
            color: Theme.of(context).textTheme.caption!.color
          ),
        )
      ],
    );
  }
}