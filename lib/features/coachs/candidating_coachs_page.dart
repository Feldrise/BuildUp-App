import 'package:buildup/core/utils/screen_utils.dart';
import 'package:buildup/core/widgets/bu_status_message.dart';
import 'package:buildup/features/coachs/coach_graphql.dart';
import 'package:buildup/features/coachs/widgets/coach_candidating_card.dart';
import 'package:buildup/features/users/user.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CandidatingCoachsPage extends StatelessWidget {
  const CandidatingCoachsPage({Key? key}) : super(key: key);

  QueryOptions<Map<String, dynamic>> _queryOptions() {
    return QueryOptions(
      document: gql(qCandidatingCoachs)
    );
  } 

  @override
  Widget build(BuildContext context) {
    return Query(
      options: _queryOptions(),
      builder: (result, {fetchMore, refetch}) {
        if (result.isLoading) {
          return const Center(child: CircularProgressIndicator(),);
        }

        if (result.hasException) {
          return Padding(
            padding: EdgeInsets.all(ScreenUtils.instance.horizontalPadding),
            child: const BuStatusMessage(
              title: "Erreur de chargement",
              message: "Nous ne parvenons pas à charger la liste des candidats coachs... Si ce problème persite, n'hésitez pas à nous contacter.",
            ),
          );
        }

        final List mapsCoachs = result.data!["users"] as List;
        final List<User> coachs = [];
        for (final map in mapsCoachs) {
          coachs.add(User.fromJson(map as Map<String, dynamic>));
        }

        if (coachs.isEmpty) return _buildEmptyInfo(context);

        return ListView(
          padding: EdgeInsets.only(
            top: ScreenUtils.instance.horizontalPadding,
            left: ScreenUtils.instance.horizontalPadding,
            right: ScreenUtils.instance.horizontalPadding
          ),
          shrinkWrap: true,
          children: [
            for (final coach in coachs) 
              CoachCandidatingCard(coach: coach, refetch: refetch)
          ],
        );
      },
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
          "Il n'y a aucune candidature coach pour le moment",
          style: TextStyle(
            color: Theme.of(context).textTheme.caption!.color
          ),
        )
      ],
    );
  }
}