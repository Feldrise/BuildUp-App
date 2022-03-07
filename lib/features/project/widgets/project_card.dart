import 'package:buildup/core/widgets/bu_card.dart';
import 'package:buildup/core/widgets/small_info.dart';
import 'package:buildup/core/widgets/titled_card_bar.dart';
import 'package:buildup/features/project/project.dart';
import 'package:buildup/features/project/widgets/project_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    Key? key,
    required this.project,
    required this.isLoggedUser
  }) : super(key: key);

  final Project project;
  final bool isLoggedUser;

  @override
  Widget build(BuildContext context) {
    return BuCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // The header
          TitledCardBar(
            title: "Projet",
            actionText: isLoggedUser ? "Modifier" : null,
            actionIcon: isLoggedUser ? Icons.edit : null,
            onActionClicked: isLoggedUser ? () {} : null,
          ),
          const SizedBox(height: 30,),

          // The project's info
          Flexible(
            child: ProjectInfo(project: project),
          )
        ],
      ),
    );
  }

 
}