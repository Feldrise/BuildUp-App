
import 'package:buildup/entities/coach.dart';
import 'package:buildup/src/pages/administration/admin_active_pages/admin_active_coachs_page/admin_view_active_coach_page/dialogs/admin_active_coach_info_dialog.dart';
import 'package:buildup/src/shared/widgets/bu_button.dart';
import 'package:buildup/src/shared/widgets/bu_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminActiveCoachInfoCard extends StatelessWidget {
  const AdminActiveCoachInfoCard({Key key, @required this.coach}) : super(key: key);
  
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
              Text("Informations Coach", style: Theme.of(context).textTheme.headline3,),
              SizedBox(
                width: 200,
                child: BuButton(
                  icon: Icons.edit,
                  text: "Modifier",
                  onPressed: () => _updateInfo(context),
                ),
              )
            ],
          ),
          const SizedBox(height: 30,),
          _buildSmallInfo("étape actuelle", Row(
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
          ))
        ],
      ),
    );
  }

  Widget _buildSmallInfo(String title, Widget info) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: 200,
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

  
  Future _updateInfo(BuildContext context) async {
    await Navigator.push<void>(
      context,
      CupertinoPageRoute(
        builder: (context) => AdminActiveCoachInfoDialog(coach: coach)
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
  }
}