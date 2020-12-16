
import 'package:buildup/entities/builder.dart';
import 'package:buildup/src/shared/dialogs/builder/builder_profile_dialog.dart';
import 'package:buildup/src/shared/widgets/general/bu_card.dart';
import 'package:buildup/src/shared/widgets/general/bu_image_widget.dart';
import 'package:buildup/src/shared/widgets/general/bu_titled_card_bar.dart';
import 'package:buildup/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BuilderProfileCard extends StatefulWidget {
  const BuilderProfileCard({
    Key key, 
    @required this.builder,
    this.onSaveProfile
  }) : super(key: key);
  
  final BuBuilder builder;

  final Function(BuBuilder) onSaveProfile;

  @override
  _BuilderProfileCardState createState() => _BuilderProfileCardState();
}

class _BuilderProfileCardState extends State<BuilderProfileCard> {
  @override
  Widget build(BuildContext context) {
    return BuCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BuTitledCardBar(
            title: widget.builder.associatedUser.fullName,
            onModified: widget.onSaveProfile == null ? null : _modifyProfile,
          ),
          const SizedBox(height: 30,),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth <= 411) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: _buildUserInfo(),
                );
              }

              return Row(
                children: _buildUserInfo(),
              );
            },
          ),
          const SizedBox(height: 15,),
          _buildBigInfo("Description", widget.builder.description),
        ],
      ),
    );
  }

  List<Widget> _buildUserInfo() {
    return [
      Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          width: 112,
          height: 112,
          child: BuImageWidget(image: widget.builder.associatedUser.profilePicture, isCircular: true,),
        ),
      ),
      const SizedBox(height: 15, width: 15,),
      Flexible(
        child: Wrap(
          children: [
            _buildSmallInfo("Date de naissance", DateFormat("dd/MM/yyyy").format(widget.builder.associatedUser.birthdate)),
            _buildSmallInfo("Département", kFrenchDepartment[widget.builder.department]),
            _buildSmallInfo("Situation", kSituations[widget.builder.situation] ?? "Inconnue"),
            _buildSmallInfo("Tag Disocrd", widget.builder.associatedUser.discordTag),
            _buildSmallInfo("Email", widget.builder.associatedUser.email),
          ],
        ),
      )
    ];
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

  Future _modifyProfile() async {
    if (widget.onSaveProfile != null) {
      await Navigator.push<void>(
        context,
        CupertinoPageRoute(
          builder: (context) => BuilderProfileDialog(
            builder: widget.builder,
            onSaveBuilderProfile: widget.onSaveProfile,
          )
        )
      );

      setState(() {});
    }
  }
}