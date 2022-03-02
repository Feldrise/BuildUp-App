import 'package:buildup/core/widgets/bu_card.dart';
import 'package:buildup/core/widgets/small_info.dart';
import 'package:buildup/features/users/user.dart';
import 'package:buildup/features/users/widgets/step_badge.dart';
import 'package:buildup/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

class BuilderCandidatingCard extends StatelessWidget {
  const BuilderCandidatingCard({
    Key? key,
    required this.builder, 
    required this.refetch
  }) : super(key: key);

  final User builder;
  final Future<QueryResult<Object?>?> Function()? refetch;

  @override
  Widget build(BuildContext context) {
    const wrapContentWidth = 200.0;

    return BuCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(child: _buildHeader(context),),
          const SizedBox(height: 20,),

          Flexible(
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                // Step badge
                SmallInfo(title: "état", width: wrapContentWidth, child: StepBadge(step: builder.step,)),

                // The actual step
                const SmallInfo(title: "étape", width: wrapContentWidth, child: Text("Inconnue",)),

                // The candidating date
                SmallInfo(
                  title: "Date", 
                  width: wrapContentWidth, 
                  child: Text(builder.createdAt != null 
                      ? DateFormat("dd/MM/yyyy").format(builder.createdAt!)
                      : "Non précisée"
                  )
                ),

                // The project
                SmallInfo(title: "Projet", width: wrapContentWidth, child: Text(builder.builder!.project!.name)),

                // The email
                SmallInfo(title: "Email", width: wrapContentWidth, child: Text(builder.email)),

                // The Discord tag
                SmallInfo(title: "Tag Discord", width: wrapContentWidth, child: Text(builder.discord ?? "Inconnue")),
              ],
            ),
          )
        ],
      )
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // The builder's name
        Text(
          "${builder.firstName} ${builder.lastName}"
        ),

        // The actions icons
        Flexible(
          child: Wrap(
            spacing: 15,
            runSpacing: 15,
            children: [
              // View 
              _buildButton(
                context, 
                icon: Icons.visibility, 
                onPressed: _onViewClicked
              ),
        
              // Edit
              _buildButton(
                context, 
                icon: Icons.edit, 
                onPressed: _onEditClicked
              ),
        
              // Delete
              _buildButton(
                context, 
                icon: Icons.delete, 
                onPressed: _onDDeleteClicked
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildButton(BuildContext context, {
    required IconData icon,
    required Function() onPressed,
  }) {
    return Container(
      width: 28, height: 28,
      decoration: BoxDecoration(
        // TODO: find something in the theme...
        color: Palette.colorLightGrey2,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            offset: Offset(0.0, 1.0),
            blurRadius: 3.0,
            spreadRadius: 0
          ),
          BoxShadow(
            color: Color(0x1f000000),
            offset: Offset(0.0, 2.0),
            blurRadius: 2.0,
            spreadRadius: 0
          ),
        ],
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon),
        color: Theme.of(context).textTheme.bodyText2!.color,
        iconSize: 14,
        splashRadius: 28,
        onPressed: onPressed,
      ),
    );
  }

  Future _onViewClicked() async {

  }

  Future _onEditClicked() async {

  }

  Future _onDDeleteClicked() async {

  }
}