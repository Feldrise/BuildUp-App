import 'package:buildup/core/widgets/bu_card.dart';
import 'package:buildup/features/authentication/user.dart';
import 'package:buildup/features/builders/bu_builder.dart';
import 'package:buildup/theme/palette.dart';
import 'package:flutter/material.dart';

class BuilderCard extends StatelessWidget {
  const BuilderCard({
    Key? key,
    required this.builder
  }) : super(key: key);

  final User builder;

  @override
  Widget build(BuildContext context) {
    return BuCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(child: _buildHeader()),
          const SizedBox(height: 12,),

          ..._buildInfos(context),

          Expanded(child: Container()),
          Align(
            alignment: Alignment.bottomCenter,
            child: OutlinedButton(
              onPressed: _onProfileClicked,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.account_circle),
                  SizedBox(width: 8,),
                  Text("Voir le profil")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _buildBadge(),),
        PopupMenuButton(
          itemBuilder: (context) => [

          ],
        )
      ],
    );
  }

  List<Widget> _buildInfos(BuildContext context) {
    return [
      // The profile picture
      Center(
        child: Container(
          width: 48, height: 48,
          decoration: BoxDecoration(
            color: Palette.colorLightGrey3,
            borderRadius: BorderRadius.circular(24)
          ),
        ),
      ),
      const SizedBox(height: 10,),

      // The name
      Text(
        "${builder.firstName} ${builder.lastName}", 
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline6,
      ),

      // The project name
      Text(
        builder.builder!.project!.name,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.caption,
      )
    ];
  }

  Widget _buildBadge() {
    // By default, the active badge
    return Row(
      children: [
        // The badge icon
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

        // The badge text
        const Flexible(child: Text("Actif", style: TextStyle(color: Color(0xff17ba63)),))
      ],
    );
  }

  Future _onProfileClicked() async {

  }
}