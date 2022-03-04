import 'package:buildup/core/widgets/dialogs/closable_dialog.dart';
import 'package:buildup/features/users/user.dart';
import 'package:flutter/material.dart';

class UserRefuseDialog extends StatelessWidget {
  const UserRefuseDialog({
    Key? key,
    required this.user
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return ClosableDialog(
      title: "Supprimer la candidature", 
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // confirmation message
          const Text("Voulez-vous vraiment supprimer la candidature ?"),
          const SizedBox(height: 12,),

          // The infos
          Flexible(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).dividerColor,
                  borderRadius: BorderRadius.circular(8)
                ),
                constraints: const BoxConstraints(maxWidth: 260),
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // The user name
                    _buildInfo(context, "Nom", "${user.firstName} ${user.lastName}"),
                    const SizedBox(height: 8,),
            
                    // Either the project or the situation
                    if (user.builder?.project != null)
                      _buildInfo(context, "Projet", user.builder!.project!.name)
                    else 
                      _buildInfo(context, "Situation", user.situation)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        OutlinedButton(
          child: const Text("Annuler"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: Row(
            children: const [
              Icon(Icons.delete),
              SizedBox(width: 4,),
              Text("Supprimer")
            ],
          ),
          onPressed: () => Navigator.of(context).pop(true),
        )
      ],
    );
  }

  Widget _buildInfo(BuildContext context, String title, String content) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1!.color,
          fontSize: 16,
          fontWeight: FontWeight.w600
        ),
        text: "$title :\n",
        children: [
          TextSpan(
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1!.color,
              fontSize: 16,
              fontWeight: FontWeight.w400
            ),
            text: content
          )
        ]
      ),
    );
  }
}