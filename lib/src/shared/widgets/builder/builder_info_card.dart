import 'package:buildup/entities/builder.dart';
import 'package:buildup/entities/user.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/src/shared/dialogs/builder/builder_info_dialog.dart';
import 'package:buildup/src/shared/widgets/general/bu_titled_card_bar.dart';
import 'package:buildup/src/shared/widgets/general/bu_card.dart';
import 'package:buildup/src/shared/widgets/general/bu_image_widget.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BuilderInfoCard extends StatefulWidget {
  const BuilderInfoCard({
    Key key, 
    @required this.builder,
    this.onSaveInfo,
  }) : super(key: key);

  final BuBuilder builder;

  final Function(BuBuilder) onSaveInfo;

  @override
  _BuilderInfoCardState createState() => _BuilderInfoCardState();
}

class _BuilderInfoCardState extends State<BuilderInfoCard> {
  @override
  Widget build(BuildContext context) {
    return BuCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BuTitledCardBar(
            title: "Informations Builder",
            onModified: widget.onSaveInfo != null ? _updateInfo : null,
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
            Wrap(
              children: [
                if (Provider.of<UserStore>(context).user.role != UserRoles.builder)
                  _buildSmallInfo("Etape actuelle", _buildCurrentStep()),
                _buildSmallInfo("Fin du programme", Text(DateFormat("dd/MM/yyyy").format(widget.builder.programEndDate)))
              ]
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
              child: InkWell(
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

  Widget _buildCurrentStep() {
    if (widget.builder.step == BuilderSteps.adminMeeting) {
      return ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 200, maxWidth: 250),
        child: Row(
          children: [
            Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                color: const Color(0xfff4bd2a),
                borderRadius: BorderRadius.circular(15)
              ),
              child: const Center(child: Icon(Icons.watch_later, size: 15, color: Colors.white,),),
            ),
            const SizedBox(width: 5,),
            const Text("Entretien avec un admin", style: TextStyle(color: Color(0xfff4bd2a)),)
          ],
        ),
      );
    }

    if (widget.builder.step == BuilderSteps.coachMeeting) {
      ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 200, maxWidth: 250),
        child: Row(
          children: [
            Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                color: const Color(0xfff4bd2a),
                borderRadius: BorderRadius.circular(15)
              ),
              child: const Center(child: Icon(Icons.watch_later, size: 15, color: Colors.white,),),
            ),
            const SizedBox(width: 5,),
            const Text("Choix du coach", style: TextStyle(color: Color(0xfff4bd2a)),)
          ],
        ),
      );
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 200, maxWidth: 250),
      child: Row(
        mainAxisSize: MainAxisSize.min,
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
      ),
    );
  }

  Future _updateInfo() async {
    await Navigator.push<void>(
      context,
      CupertinoPageRoute(
        builder: (context) => BuilderInfoDialog(
          builder: widget.builder,
          onSaveInfo: widget.onSaveInfo,
        )
      )
    );

    setState(() {});
  }
}