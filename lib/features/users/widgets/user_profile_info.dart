import 'package:buildup/core/utils/constants.dart';
import 'package:buildup/core/widgets/small_info.dart';
import 'package:buildup/features/users/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserProfileInfo extends StatelessWidget {
  const UserProfileInfo({
    Key? key,
    required this.user,
    this.showProfilePicture = true,
  }) : super(key: key);
  
  final User user;
  final bool showProfilePicture;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // The users info
        Flexible(
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth <= 411) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: _buildInfo(context),
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildInfo(context),
              );
            },
          ),
        ),
        const SizedBox(height: 30,),

        // Description
        Flexible(
          child: RichText(
            text: TextSpan(
              text: "Description :\n",
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: user.description,
                  style: Theme.of(context).textTheme.bodyText2
                )
              ]
            )
          ),
        )
      ],
    );
  }

  List<Widget> _buildInfo(BuildContext context) {
    return [
      // The profil picture
      if (showProfilePicture) ...{
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 112, height: 112,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(56),
              child: Image.network(
                "$kImagesUrls/users/${user.id}.jpg",
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
        const SizedBox(height: 15, width: 30,),
      },

      // The info
      Flexible(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // First Wrap
            Flexible(
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  // The birthdate
                  SmallInfo(
                    title: "Date de naissance", 
                    width: 200,
                    child: Text(user.birthdate != null 
                      ? DateFormat("dd/MM/yyyy").format(user.birthdate!)
                      : "Non précisée"
                    ),
                  ),

                  // The departement
                  const SmallInfo(
                    title: "Département", 
                    width: 200,
                    child: Text("Non précisé")
                  ),

                  // The situation
                  SmallInfo(
                    title: "Situation",
                    width: 200,
                    child: Text(user.situation)
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16,),

            // The second wrap
            Flexible(
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  // Discord Tag
                  SmallInfo(
                    title: "Tag Discord", 
                    width: 200,
                    child: Text(user.discord ?? "Non précisé"),
                  ),

                  // The departement
                  SmallInfo(
                    title: "Email", 
                    width: 200,
                    child: Text(user.email)
                  ),

                  // The situation
                  SmallInfo(
                    title: "Linkedin",
                    width: 200,
                    child: Row(
                      children: [
                        Icon(
                          Icons.account_circle, 
                          size: 16,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 4,),
                        Text(
                          "Profil Linkedin",
                          style: TextStyle(color: Theme.of(context).primaryColor),
                        )
                      ],
                    )
                  ),
                ],
              ),
            )
          ],
        ),
      )
    ];
  }
}