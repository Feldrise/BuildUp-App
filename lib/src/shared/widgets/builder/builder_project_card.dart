import 'package:buildup/entities/builder.dart';
import 'package:buildup/src/shared/dialogs/builder/builder_project_dialog.dart';
import 'package:buildup/src/shared/widgets/general/bu_titled_card_bar.dart';
import 'package:buildup/src/shared/widgets/general/bu_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BuilderProjectCard extends StatefulWidget {
  const BuilderProjectCard({
    Key? key, 
    required this.builder,
    this.onSaveProject,
  }) : super(key: key);

  final BuBuilder builder;

  final Function(BuBuilder)? onSaveProject;

  @override
  _BuilderProjectCardState createState() => _BuilderProjectCardState();
}

class _BuilderProjectCardState extends State<BuilderProjectCard> {
  @override
  Widget build(BuildContext context) {
    return BuCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BuTitledCardBar(
            title: "Projet",
            onModified: widget.onSaveProject != null ? _modifyProject : null,
          ),
          const SizedBox(height: 30,),
          Wrap(
            children: [
              _buildSmallInfo("Nom", widget.builder.associatedProjects.first.name),
              _buildSmallInfo("Catégorie", widget.builder.associatedProjects.first.categorie),
              _buildSmallInfo("Date de lancement", DateFormat("dd/MM/yyyy").format(widget.builder.associatedProjects.first.launchDate)),
              _buildSmallInfo("Projet lucratif", widget.builder.associatedProjects.first.isLucrative ? "Oui" : "Non"),
              _buildSmallInfo("Projet déclaré", widget.builder.associatedProjects.first.isDeclared ? "Oui" : "Non"),
            ],
          ),
          const SizedBox(height: 30,),
          _buildBigInfo("Mots clés :", widget.builder.associatedProjects.first.keywords),
          const SizedBox(height: 15),
          _buildBigInfo("Description :", widget.builder.associatedProjects.first.description),
          const SizedBox(height: 15),
          _buildBigInfo("L'équipe :", widget.builder.associatedProjects.first.team)  
        ]
      )
    );
  }

  Widget _buildSmallInfo(String title, String info) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: 200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.toUpperCase(), style: const TextStyle(fontSize: 14, color: Color(0xff919191)),),
          const SizedBox(height: 5,),
          Text(info)
        ],  
      ),
    );
  } 

  Widget _buildBigInfo(String title, String info) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold),),
            const SizedBox(height: 7,),
            Text(info)
          ],  
        ),
      ),
    );
  } 

  Future _modifyProject() async {
    await Navigator.push<void>(
      context,
      CupertinoPageRoute(
        builder: (context) => BuilderProjectDialog(
          builder: widget.builder,
          onSaveProject: widget.onSaveProject!,
        )
      )
    );

    setState(() {});
  }
}