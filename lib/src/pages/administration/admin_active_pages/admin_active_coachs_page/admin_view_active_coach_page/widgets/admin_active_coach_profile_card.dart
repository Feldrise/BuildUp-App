import 'package:buildup/entities/coach.dart';
import 'package:buildup/src/shared/widgets/bu_button.dart';
import 'package:buildup/src/shared/widgets/bu_card.dart';
import 'package:buildup/src/shared/widgets/bu_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdminActiveCoachProfileCard extends StatelessWidget {
  const AdminActiveCoachProfileCard({Key key, @required this.coach}) : super(key: key);
  
  final Coach coach;

  @override
  Widget build(BuildContext context) {
    return BuCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(coach.associatedUser.fullName, style: Theme.of(context).textTheme.headline3,),
              SizedBox(
                width: 200,
                child: BuButton(
                  icon: Icons.edit,
                  text: "Modifier",
                  onPressed: () {},
                ),
              )
            ],
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
          _buildBigInfo("Description", coach.description),
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
          child: BuImageWidget(image: coach.associatedUser.profilePicture, isCircular: true,),
        ),
      ),
      const SizedBox(height: 15, width: 15,),
      Flexible(
        child: Wrap(
                  children: [
            _buildSmallInfo("Date de naissance", DateFormat("yyyy/MM/dd").format(coach.associatedUser.birthdate)),
            _buildSmallInfo("Département", coach.department.toString()),
            _buildSmallInfo("Situation", coach.situation),
            _buildSmallInfo("Tag Disocrd", coach.associatedUser.discordTag),
            _buildSmallInfo("Email", coach.associatedUser.email),
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
}