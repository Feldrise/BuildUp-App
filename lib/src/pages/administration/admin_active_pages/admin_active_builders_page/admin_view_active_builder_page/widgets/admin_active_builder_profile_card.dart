
import 'package:buildup/entities/builder.dart';
import 'package:buildup/src/pages/administration/admin_active_pages/admin_active_builders_page/admin_view_active_builder_page/dialogs/admin_active_builder_profile_dialog.dart';
import 'package:buildup/src/shared/widgets/bu_button.dart';
import 'package:buildup/src/shared/widgets/bu_card.dart';
import 'package:buildup/src/shared/widgets/bu_icon_button.dart';
import 'package:buildup/src/shared/widgets/bu_image_widget.dart';
import 'package:buildup/utils/colors.dart';
import 'package:buildup/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdminActiveBuilderProfileCard extends StatefulWidget {
  const AdminActiveBuilderProfileCard({Key key, @required this.builder}) : super(key: key);
  
  final BuBuilder builder;

  @override
  _AdminActiveBuilderProfileCardState createState() => _AdminActiveBuilderProfileCardState();
}

class _AdminActiveBuilderProfileCardState extends State<AdminActiveBuilderProfileCard> {
  @override
  Widget build(BuildContext context) {
    return BuCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final bool showText = constraints.maxWidth > 411;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: Text(widget.builder.associatedUser.fullName, style: Theme.of(context).textTheme.headline3,)),
                  if (showText)
                    Container(
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: BuButton(
                        icon: Icons.edit,
                        text: "Modifier",
                        onPressed: () => _modifyProfile(context),
                      ),
                    )
                  else 
                    Container(
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: BuIconButton(
                        backgroundColor: colorPrimary,
                        icon: Icons.edit,
                        iconSize: 24,
                        onPressed: () => _modifyProfile(context),
                      ),
                    )
                ],
              );
            },
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
            _buildSmallInfo("Situation", kSituations[widget.builder.situation]),
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

  Future _modifyProfile(BuildContext context) async {
    await Navigator.push<void>(
      context,
      CupertinoPageRoute(
        builder: (context) => AdminActiveBuilderProfileDialog(builder: widget.builder)
      )
    );

    setState(() {});
  }
}