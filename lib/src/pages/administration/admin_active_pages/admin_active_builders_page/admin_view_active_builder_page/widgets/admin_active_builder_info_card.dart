import 'package:buildup/entities/builder.dart';
import 'package:buildup/src/pages/administration/admin_active_pages/admin_active_builders_page/admin_view_active_builder_page/dialogs/admin_active_builder_info_dialog.dart';
import 'package:buildup/src/pages/administration/admin_active_pages/widgets/admin_card_title_bar.dart';
import 'package:buildup/src/shared/widgets/bu_card.dart';
import 'package:buildup/src/shared/widgets/bu_image_widget.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminActiveBuilderInfoCard extends StatefulWidget {
  const AdminActiveBuilderInfoCard({Key key, @required this.builder}) : super(key: key);

  final BuBuilder builder;

  @override
  _AdminActiveBuilderInfoCardState createState() => _AdminActiveBuilderInfoCardState();
}

class _AdminActiveBuilderInfoCardState extends State<AdminActiveBuilderInfoCard> {
  @override
  Widget build(BuildContext context) {
    return BuCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AdminCardTitleBar(
            title: "Informations Builder",
            onModified: _updateInfo,
          ),
          const SizedBox(height: 30,),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 822) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildInfo(),
                );
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _buildInfo(),
              );
            },
          )
        ]
      )
    );
  }

  List<Widget> _buildInfo() {
    return [
      Flexible(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 265),
          child: BuImageWidget(image: widget.builder.builderCard,),
        ),
      ),
      const SizedBox(width: 30, height: 30,),
      Flexible(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: _buildSmallInfo("Etape actuelle", Row(
                children: [
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
                  const Text("Actif", style: TextStyle(color: Color(0xff17ba63)),)
                ],
              )),
            ),
            Wrap(
              children: [
                _buildSmallInfo("Coach assigné", Text(widget.builder.associatedCoach != null ? widget.builder.associatedCoach.associatedUser.fullName : "Pas de coach")),
                _buildSmallInfo("Référent assigné", Text(widget.builder.associatedNtfReferent != null ? widget.builder.associatedNtfReferent.name : "Pas de référent")),
              ]
            ),
            const SizedBox(height: 15,),
            Wrap(
              children: [
                if (widget.builder.associatedCoach != null)
                  _buildSmallInfo("Contact coach", _buildContactWidget(widget.builder.associatedCoach.associatedUser.email, widget.builder.associatedCoach.associatedUser.discordTag)),

                if (widget.builder.associatedNtfReferent != null) 
                  _buildSmallInfo("Contact Référent", _buildContactWidget(widget.builder.associatedNtfReferent.email, widget.builder.associatedNtfReferent.discordTag))
                
              ]
            )
          ],
        ),
      )
    ];
  }

  Widget _buildSmallInfo(String title, Widget info) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      constraints: const BoxConstraints(minWidth: 200, maxWidth: 250),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.toUpperCase(), style: const TextStyle(fontSize: 14, color: Color(0xff919191)),),
          const SizedBox(height: 5,),
          info
        ],  
      ),
    );
  } 

  Widget _buildContactWidget(String email, String discordTag) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Icon(Icons.mail, size: 15,),
            const SizedBox(width: 5,),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  launch('mailto:$email');
                },
                child: Text(email, style: const TextStyle(color: colorPrimary))
              ),
            )
          ],
        ),
        Row(
          children: [
            const Icon(Icons.switch_account, size: 15,),
            const SizedBox(width: 5,),
            Expanded(
              child: Text(discordTag)
            )
          ],
        )
      ],
    );
  }

  Future _updateInfo() async {
    await Navigator.push<void>(
      context,
      CupertinoPageRoute(
        builder: (context) => AdminActiveBuilderInfoDialog(builder: widget.builder)
      )
    );

    setState(() {});
  }
}