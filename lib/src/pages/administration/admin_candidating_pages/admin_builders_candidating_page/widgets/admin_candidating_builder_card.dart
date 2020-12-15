import 'package:buildup/entities/builder.dart';
import 'package:buildup/src/pages/administration/admin_candidating_pages/admin_builders_candidating_page/dialogs/admin_delete_candidating_builder_dialog.dart';
import 'package:buildup/src/pages/administration/admin_candidating_pages/admin_builders_candidating_page/dialogs/admin_update_candidating_builder.dart';
import 'package:buildup/src/pages/administration/admin_candidating_pages/admin_builders_candidating_page/dialogs/admin_view_candidating_builder_dialog.dart';
import 'package:buildup/src/providers/candidating_builders_store.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/src/shared/dialogs/dialogs.dart';
import 'package:buildup/src/shared/widgets/general/bu_card.dart';
import 'package:buildup/src/shared/widgets/general/bu_icon_button.dart';
import 'package:buildup/src/shared/widgets/general/bu_status_message.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AdminCandidatingBuilderCard extends StatefulWidget {
  const AdminCandidatingBuilderCard({
    Key key, 
    @required this.builder
  }) : super(key: key);
  
  final BuBuilder builder;

  @override
  _AdminCandidatingBuilderCardState createState() => _AdminCandidatingBuilderCardState();
}

class _AdminCandidatingBuilderCardState extends State<AdminCandidatingBuilderCard> {
  bool _hasError = false;
  String _errorMessage = "";

  List<Widget> actions(BuildContext context) {
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
      buildInfo("étape", Text(BuilderSteps.detailled[widget.builder.step] ?? "Inconnue")),
      // TODO replace by the candidating date
      buildInfo("Date", const Text("20/08/2020")),
      buildInfo("Projet", Text(widget.builder.associatedProjects.first.name)),
      buildInfo("Email", Text(widget.builder.associatedUser.email)),
      buildInfo("Tag Discord", Text(widget.builder.associatedUser.discordTag))
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
                      child: Text(widget.builder.associatedUser.fullName, style: Theme.of(context).textTheme.headline6,),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Wrap(
                          children: actions(context),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              if (_hasError && _errorMessage.isNotEmpty) 
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: BuStatusMessage(
                      title: "Erreur",
                      message: _errorMessage,
                    ),
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
                    buildWrappedInfo(widget, showTable: showTable)
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

  Widget buildWrappedInfo(Widget info, {bool showTable}) {
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
      width: 200,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor
          )
        )
      ),
      child: info,
    );
  }

  Future _viewBuilder() async {
    await showDialog<void>(
      context: context,
      builder: (context) => AdminViewCandidatingBuilderDialog(builder: widget.builder,)
    );
  }

  Future _editBuilder() async {
    final bool updated = await showDialog(
      context: context,
      builder: (context) => AdminUpdateCandidatingBuilderDialog(builder: widget.builder,)
    );

    if (updated != null && updated) {
      final String authorization = Provider.of<UserStore>(context, listen: false).authentificationHeader;

      final GlobalKey<State> keyLoader = GlobalKey<State>();
      Dialogs.showLoadingDialog(context, keyLoader, "Mise à jour..."); 

      try {
        await Provider.of<CandidatingBuilderStore>(context, listen: false).updateBuilder(authorization, widget.builder);
      } on PlatformException catch (e) {
        setState(() {
          _hasError = true;
          _errorMessage = "Impossible de mettre à jour ce builder : ${e.message}";
        });
      } on Exception catch(e) {
        setState(() {
          _hasError = true;
          _errorMessage = "Impossible de mettre à jour ce builder : $e";
        });
      }

      Navigator.of(keyLoader.currentContext,rootNavigator: true).pop(); 
    }
  }

  Future _deleteBuilder() async {
    final bool delete = await showDialog(
      context: context,
      builder: (context) => AdminDeleteCandidatingBuilderDialog(builder: widget.builder,)
    );

    if (delete != null && delete) {
      final String authorization = Provider.of<UserStore>(context, listen: false).authentificationHeader;

      final GlobalKey<State> keyLoader = GlobalKey<State>();
      Dialogs.showLoadingDialog(context, keyLoader, "Suppression..."); 

      try {
        await Provider.of<CandidatingBuilderStore>(context, listen: false).refuseBuilder(authorization, widget.builder);
      } on PlatformException catch (e) {
        setState(() {
          _hasError = true;
          _errorMessage = "Impossible de refuser ce builder : ${e.message}";
        });
      } on Exception catch(e) {
        setState(() {
          _hasError = true;
          _errorMessage = "Impossible de refuser ce builder : $e";
        });
      }

      Navigator.of(keyLoader.currentContext,rootNavigator: true).pop(); 
    }
  }
}