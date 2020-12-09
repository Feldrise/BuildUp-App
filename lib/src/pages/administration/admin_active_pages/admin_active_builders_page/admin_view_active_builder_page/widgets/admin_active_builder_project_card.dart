import 'package:buildup/entities/builder.dart';
import 'package:buildup/src/pages/administration/admin_active_pages/widgets/admin_card_title_bar.dart';
import 'package:buildup/src/shared/widgets/bu_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdminActiveBuilderProjectCard extends StatelessWidget {
  const AdminActiveBuilderProjectCard({Key key, @required this.builder}) : super(key: key);

  final BuBuilder builder;

  @override
  Widget build(BuildContext context) {
    return BuCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AdminCardTitleBar(
            title: "Projet",
            onModified: () {},
          ),
          const SizedBox(height: 30,),
          Wrap(
            children: [
              _buildSmallInfo("Nom", builder.associatedProjects.first.name),
              _buildSmallInfo("Catégorie", builder.associatedProjects.first.categorie),
              _buildSmallInfo("Date de lancement", DateFormat("dd/MM/yyyy").format(builder.associatedProjects.first.launchDate)),
              _buildSmallInfo("Projet lucratif", builder.associatedProjects.first.isLucrative ? "Oui" : "Nom"),
              _buildSmallInfo("Projet déclaré", builder.associatedProjects.first.isDeclared ? "Oui" : "Non"),
            ],
          ),
          const SizedBox(height: 30,),
          _buildBigInfo("Mots clés :", builder.associatedProjects.first.keywords),
          const SizedBox(height: 15),
          _buildBigInfo("Description :", builder.associatedProjects.first.description),
          const SizedBox(height: 15),
          _buildBigInfo("L'équipe :", builder.associatedProjects.first.team)  
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

}