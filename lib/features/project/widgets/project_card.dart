import 'package:buildup/core/widgets/bu_card.dart';
import 'package:buildup/core/widgets/titled_card_bar.dart';
import 'package:buildup/features/project/project.dart';
import 'package:buildup/features/project/widgets/project_card_form.dart';
import 'package:buildup/features/project/widgets/project_info.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ProjectCard extends StatefulWidget {
  const ProjectCard({
    Key? key,
    required this.project,
    required this.userID,
    required this.isLoggedUser,
    required this.isAdmin,
    required this.refetch,
  }) : super(key: key);

  final Project project;

  final String userID;
  final bool isLoggedUser;
  final bool isAdmin;

  final Refetch? refetch;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return BuCard(
      child: Builder(
        builder: (context) {
          if (_currentPage == 1) {
            return ProjectCardForm(
              project: widget.project,
              userID: widget.userID,
              onPop: () => _animateScroll(0),
              refetch: widget.refetch,
            );
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // The header
              TitledCardBar(
                title: "Projet",
                actionText: (widget.isLoggedUser || widget.isAdmin) ? "Modifier" : null,
                actionIcon: (widget.isLoggedUser || widget.isAdmin) ? Icons.edit : null,
                onActionClicked: (widget.isLoggedUser || widget.isAdmin) ? () {
                  _animateScroll(1);
                } : null,
              ),
              const SizedBox(height: 30,),

              // The project's info
              Flexible(
                child: ProjectInfo(project: widget.project),
              )
            ],
          );
        }
      ),
    );
  }

  Future _animateScroll(int page) async  {
    setState(() {
      _currentPage = page;
    });
  }
}