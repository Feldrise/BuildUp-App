import 'package:buildup/core/utils/constants.dart';
import 'package:buildup/core/widgets/bu_card.dart';
import 'package:buildup/features/users/user.dart';
import 'package:buildup/features/users/user_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CoachCard extends StatelessWidget {
  const CoachCard({
    Key? key,
    required this.coach,
    required this.refetch,
  }) : super(key: key);

  final User coach;
  final Refetch? refetch;

  @override
  Widget build(BuildContext context) {
    return BuCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(child: _buildHeader()),
          const SizedBox(height: 12,),

          ..._buildInfos(context),

          Expanded(child: Container()),
          Align(
            alignment: Alignment.bottomCenter,
            child: OutlinedButton(
              onPressed: () => _onProfileClicked(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.account_circle),
                  SizedBox(width: 8,),
                  Text("Voir le profil")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _buildBadge(),),
        PopupMenuButton(
          itemBuilder: (context) => [

          ],
        )
      ],
    );
  }

  List<Widget> _buildInfos(BuildContext context) {
    return [
      // The profile picture
      Center(
        child: SizedBox(
          width: 48, height: 48,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(56),
            child: Image.network(
              "$kImagesUrls/users/${coach.id}.jpg",
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) => loadingProgress == null ? child : Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                    : null,
                ),
              ),
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  "assets/images/buildup_mini.png",
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ),
      ),
      const SizedBox(height: 10,),

      // The name
      Text(
        "${coach.firstName} ${coach.lastName}", 
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline6,
      ),

      // The project name
      Text(
        coach.situation,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.caption,
      )
    ];
  }

  Widget _buildBadge() {
    // By default, the active badge
    return Row(
      children: [
        // The badge icon
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            color: const Color(0xff17ba63),
            borderRadius: BorderRadius.circular(15)
          ),
          child: const Center(child: Icon(Icons.check, size: 15, color: Colors.white,),),
        ),
        const SizedBox(width: 5,),

        // The badge text
        const Flexible(child: Text("Actif", style: TextStyle(color: Color(0xff17ba63)),))
      ],
    );
  }

  Future _onProfileClicked(BuildContext context) async {
    bool shouldRefetch = await Navigator.of(context).push<bool?>(
      MaterialPageRoute<bool?>(
        builder: (context) => UserProfilePage(
          userId: coach.id!,
          appBarTitle: "Coach : ${coach.firstName} ${coach.lastName}",
        ),
      )
    ) ?? false;

    if (shouldRefetch && refetch != null) {
      refetch!();
    }
  }

}