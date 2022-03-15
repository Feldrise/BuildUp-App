import 'package:buildup/core/widgets/bu_card.dart';
import 'package:buildup/core/widgets/bu_status_message.dart';
import 'package:buildup/core/widgets/small_info.dart';
import 'package:buildup/features/builders/bu_builder.dart';
import 'package:buildup/features/users/dialogs/user_candidating_dialog.dart';
import 'package:buildup/features/users/dialogs/user_profile_dialog.dart';
import 'package:buildup/features/users/dialogs/user_refuse_dialog.dart';
import 'package:buildup/features/users/user.dart';
import 'package:buildup/features/users/users_graphql.dart';
import 'package:buildup/features/users/widgets/step_badge.dart';
import 'package:buildup/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

class BuilderCandidatingCard extends StatefulWidget {
  const BuilderCandidatingCard({
    Key? key,
    required this.builder, 
    required this.refetch
  }) : super(key: key);

  final User builder;
  final Future<QueryResult<Object?>?> Function()? refetch;

  @override
  State<BuilderCandidatingCard> createState() => _BuilderCandidatingCardState();
}

class _BuilderCandidatingCardState extends State<BuilderCandidatingCard> {
  String _statusMessage = "";

  MutationOptions _options() {
    return MutationOptions<dynamic>(
      document: gql(mUserUpdateStepStatus),
      onError: (error) {
        setState(() {
          _statusMessage = "L'utilisateur n'a pas pu être mise à jour... Contactez le support ou réessayer $error";
        });
      },
      onCompleted: (dynamic data) {
        if (data == null) return;

        setState(() {
          _statusMessage = "";
        });

        if (widget.refetch != null) widget.refetch!();
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    const wrapContentWidth = 200.0;

    return Mutation<dynamic>(
      options: _options(),
      builder: (runMutation, mutationResult) {
        return BuCard(
          child: mutationResult?.isLoading ?? false ? const Center(child: CircularProgressIndicator(),) : Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(child: _buildHeader(context, runMutation),),
              const SizedBox(height: 20,),

              if (_statusMessage.isNotEmpty) ...{
                BuStatusMessage(
                  message: _statusMessage,
                ),
                const SizedBox(height: 20,),
              },
        
              Flexible(
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    // Step badge
                    SmallInfo(title: "état", width: wrapContentWidth, child: StepBadge(step: widget.builder.step,)),
        
                    // The actual step
                    SmallInfo(title: "étape", width: wrapContentWidth, child: Text(BuilderSteps.detailled[widget.builder.step] ?? "Inconnue")),
        
                    // The candidating date
                    SmallInfo(
                      title: "Date", 
                      width: wrapContentWidth, 
                      child: Text(widget.builder.createdAt != null 
                          ? DateFormat("dd/MM/yyyy").format(widget.builder.createdAt!)
                          : "Non précisée"
                      )
                    ),
        
                    // The project
                    SmallInfo(title: "Projet", width: wrapContentWidth, child: Text(widget.builder.builder!.project!.name)),
        
                    // The email
                    SmallInfo(title: "Email", width: wrapContentWidth, child: Text(widget.builder.email)),
        
                    // The Discord tag
                    SmallInfo(title: "Tag Discord", width: wrapContentWidth, child: Text(widget.builder.discord ?? "Inconnue")),
                  ],
                ),
              )
            ],
          )
        );
      }
    );
  }

  Widget _buildHeader(BuildContext context, RunMutation runMutation) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // The builder's name
        Text(
          "${widget.builder.firstName} ${widget.builder.lastName}"
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
                onPressed: () => _onViewClicked(context)
              ),
        
              // Edit
              _buildButton(
                context, 
                icon: Icons.edit, 
                onPressed: () => _onEditClicked(context, runMutation)
              ),
        
              // Delete
              _buildButton(
                context, 
                icon: Icons.delete, 
                onPressed: () =>_onDeleteClicked(context, runMutation)
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

  Future _onViewClicked(BuildContext context) async {
    await showDialog<dynamic>(
      context: context, 
      builder: (context) => UserProfilDialog(
        userId: widget.builder.id!, 
        dialogTitle: "${widget.builder.firstName} ${widget.builder.lastName}"
      )
    );
  }

  Future _onEditClicked(BuildContext context, RunMutation runMutation) async {
    Map<String, dynamic>? newParams = await showDialog<Map<String, dynamic>?>(
      context: context, 
      builder: (context) => UserCandidatingDialog(user: widget.builder)
    );

    if (newParams != null) {
      runMutation(newParams);
    } 
  }

  Future _onDeleteClicked(BuildContext context, RunMutation runMutation) async {
    bool delete = await showDialog<bool?>(
      context: context,
      builder: (context) => UserRefuseDialog(user: widget.builder)
    ) ?? false;

    if (delete) {
      runMutation(<String, dynamic>{
        "id": widget.builder.id,
        "status": UserStatus.deleted
      });
    }
  }
}