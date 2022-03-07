import 'package:buildup/core/widgets/small_info.dart';
import 'package:buildup/features/project/project.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProjectInfo extends StatelessWidget {
  const ProjectInfo({
    Key? key,
    required this.project
  }) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // The projects info
        Flexible(
          child: _buildInfo(context),
        ),
        const SizedBox(height: 30,),

        // Keywords
        Flexible(
          child: RichText(
            text: TextSpan(
              text: "Mots clés :\n",
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: project.keywords ?? "Pas de mots clés",
                  style: Theme.of(context).textTheme.bodyText2
                )
              ]
            )
          ),
        ),
        const SizedBox(height: 20,),

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
                  text: project.description,
                  style: Theme.of(context).textTheme.bodyText2
                )
              ]
            )
          ),
        ),
        const SizedBox(height: 20,),
        // Team
        Flexible(
          child: RichText(
            text: TextSpan(
              text: "L'équipe :\n",
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: project.team,
                  style: Theme.of(context).textTheme.bodyText2
                )
              ]
            )
          ),
        )
      ],
    );
  }

   Widget _buildInfo(BuildContext context) {
    // The info
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // First Wrap
        Flexible(
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              // The name
              SmallInfo(
                title: "Nom", 
                width: 200,
                child: Text(project.name)
              ),

              // The catégorie
              SmallInfo(
                title: "Catégorie",
                width: 200,
                child: Text(project.categorie ?? "Non précisée")
              ),

              // The launch date
              SmallInfo(
                title: "Date de lancement", 
                width: 200,
                child: Text(project.launchDate != null 
                  ? DateFormat("dd/MM/yyyy").format(project.launchDate!)
                  : "Non précisée"
                ),
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
              // Is it lucratif ?
              SmallInfo(
                title: "Projet lucratif", 
                width: 200,
                child: Text((project.isLucarative ?? false) ? "Oui" : "Non"),
              ),

              // Is it officialy registered
              SmallInfo(
                title: "Projet déclaré", 
                width: 200,
                child: Text((project.isOfficialyRegistered ?? false) ? "Oui" : "Non")
              ),
            ],
          ),
        )
      ],
    );
  }
}