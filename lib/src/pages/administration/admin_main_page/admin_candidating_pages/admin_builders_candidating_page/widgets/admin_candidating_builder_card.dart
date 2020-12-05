import 'package:buildup/entities/builder.dart';
import 'package:buildup/src/shared/widgets/bu_card.dart';
import 'package:buildup/src/shared/widgets/bu_icon_button.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';

class AdminCandidatingBuilderCard extends StatelessWidget {
  const AdminCandidatingBuilderCard({
    Key key, 
    @required this.builder
  }) : super(key: key);
  
  final BuBuilder builder;

  List<Widget> actions(){
    return [
      BuIconButton(
        icon: Icons.visibility, 
        onPressed: _viewBuilder
      ),
      const SizedBox(width: 10.0,),
      BuIconButton(
        icon: Icons.edit, 
        onPressed: _editBuilder
      ),
      const SizedBox(width: 10.0,),
      BuIconButton(
        icon: Icons.delete, 
        onPressed: _deleteBuilder
      ),
    ];
  }

  List<Widget> infos() {
    return [
        // Row(
      //   children: [
      //     buildInfo(
      //       "état", 
      //       Row(
      //         mainAxisSize: MainAxisSize.min,
      //         children: const [
      //           Icon(Icons.access_time, size: 16, color: colorYellow,),
      //           SizedBox(width: 3,),
      //           Text("En attente", style: TextStyle(color: colorYellow),)
      //         ],
      //       )
      //     ),
      //     buildInfo("étape", Text(builder.step ?? "Inconnue"))
      //   ],
      // ),
      buildInfo(
        "état", 
        Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.access_time, size: 16, color: colorYellow,),
            SizedBox(width: 3,),
            Text("En attente", style: TextStyle(color: colorYellow),)
          ],
        )
      ),
      buildInfo("étape", Text(builder.step ?? "Inconnue")),
      // TODO replace by the candidating date
      buildInfo("Date", const Text("20/08/2020")),
      buildInfo("Projet", Text(builder.associatedProjects.first.name)),
      buildInfo("Email", Text(builder.associatedUser.email)),
      buildInfo("Tag Discord", Text(builder.associatedUser.discordTag))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool showTable = constraints.maxWidth > 900;

        return BuCard(
          padding: showTable ? EdgeInsets.zero : const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: showTable ? const EdgeInsets.all(15.0) : EdgeInsets.zero,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(builder.associatedUser.fullName, style: Theme.of(context).textTheme.headline6,),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Wrap(
                          children: actions(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              if (showTable)
                Container(
                  height: 1,
                  color: Theme.of(context).dividerColor
                ),
                
              Wrap(
                children: [
                  for (final widget in infos()) 
                    // widget,
                    buildWrappedInfo(context, widget, showTable: showTable)
                ],
              )
            ],
          )
        );
      },
    );
  }

  Widget buildInfo(String title, Widget info) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title.toUpperCase(), style: const TextStyle(fontSize: 14, color: Color(0xff919191)),),
        const SizedBox(height: 5,),
        info
      ],  
    );
  }

  Widget buildWrappedInfo(BuildContext context, Widget info, {bool showTable}) {
    if (showTable) {
      return Container(
        padding: const EdgeInsets.only(top: 8.0, left: 10, bottom: 8.0, right: 50),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Theme.of(context).dividerColor
            )
          )
        ),
        child: info,
      );
    }

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor
          )
        )
      ),
      child: SizedBox(width: 200, child: info),
    );
  }

  Future _viewBuilder() async {

  }

  Future _editBuilder() async {

  }

  Future _deleteBuilder() async {

  }
}