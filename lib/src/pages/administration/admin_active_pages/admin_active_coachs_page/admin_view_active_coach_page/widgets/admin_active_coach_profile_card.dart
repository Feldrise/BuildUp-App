import 'package:buildup/entities/coach.dart';
import 'package:buildup/src/pages/administration/admin_active_pages/admin_active_coachs_page/admin_view_active_coach_page/dialogs/admin_active_coach_profile_dialog.dart';
import 'package:buildup/src/shared/widgets/general/bu_titled_card_bar.dart';
import 'package:buildup/src/shared/widgets/general/bu_card.dart';
import 'package:buildup/src/shared/widgets/general/bu_image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdminActiveCoachProfileCard extends StatefulWidget {
  const AdminActiveCoachProfileCard({Key key, @required this.coach}) : super(key: key);
  
  final Coach coach;

  @override
  _AdminActiveCoachProfileCardState createState() => _AdminActiveCoachProfileCardState();
}

class _AdminActiveCoachProfileCardState extends State<AdminActiveCoachProfileCard> {
  @override
  Widget build(BuildContext context) {
    return BuCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BuTitledCardBar(
            title: widget.coach.associatedUser.fullName,
            onModified: _modifyProfile,
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
          _buildBigInfo("Description", widget.coach.description),
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
          child: BuImageWidget(image: widget.coach.associatedUser.profilePicture, isCircular: true,),
        ),
      ),
      const SizedBox(height: 15, width: 15,),
      Flexible(
        child: Wrap(
                  children: [
            _buildSmallInfo("Date de naissance", DateFormat("dd/MM/yyyy").format(widget.coach.associatedUser.birthdate)),
            _buildSmallInfo("Département", widget.coach.department.toString()),
            _buildSmallInfo("Situation", widget.coach.situation),
            _buildSmallInfo("Tag Disocrd", widget.coach.associatedUser.discordTag),
            _buildSmallInfo("Email", widget.coach.associatedUser.email),
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
    await Navigator.push<void>(
      context,
      CupertinoPageRoute(
        builder: (context) => AdminActiveCoachProfileDialog(coach: widget.coach)
      )
      // PageRouteBuilder(
      //   pageBuilder: (context, animation, anotherAnimation) => AdminActiveCoachProfileDialog(coach: coach),
      //   transitionsBuilder: (context, animation, anotherAnimation, child) {
      //     animation = CurvedAnimation(parent: animation, curve: Curves.linear);

      //     return FadeTransition(
      //       opacity: animation,
      //       child: child,
      //     );
      //   }
      // )
    );

    setState(() {});
  }
}