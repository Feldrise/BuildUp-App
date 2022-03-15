import 'package:buildup/core/widgets/dialogs/closable_dialog.dart';
import 'package:buildup/core/widgets/inputs/bu_dropdown.dart';
import 'package:buildup/features/builders/bu_builder.dart';
import 'package:buildup/features/coachs/coach.dart';
import 'package:buildup/features/users/user.dart';
import 'package:flutter/material.dart';

class UserCandidatingDialog extends StatefulWidget {
  const UserCandidatingDialog({
    Key? key,
    required this.user,
  }) : super(key: key);
    
  final User user;

  @override
  State<UserCandidatingDialog> createState() => _UserCandidatingDialogState();
}

class _UserCandidatingDialogState extends State<UserCandidatingDialog> {
  late String _currentUserStatus;
  late String _currentUserStep;

  void _initialize() {
    _currentUserStatus = widget.user.status;
    _currentUserStep = widget.user.step;
  }

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  @override
  void didUpdateWidget(covariant UserCandidatingDialog oldWidget) {
    super.didUpdateWidget(oldWidget);

    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return ClosableDialog(
      title: "Modifier la candidature", 
      child: _buildContent(context),
      actions: [
        OutlinedButton(
          child: const Text("Annuler"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: Row(
            children: const [
              Icon(Icons.edit),
              SizedBox(width: 4,),
              Text("Modifier")
            ],
          ),
          onPressed: _onSubmit,
        )
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // The user's info
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).dividerColor,
              borderRadius: BorderRadius.circular(8)
            ),
            constraints: const BoxConstraints(maxWidth: 260),
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // The user name
                _buildInfo(context, "Nom", "${widget.user.firstName} ${widget.user.lastName}"),
                const SizedBox(height: 8,),
        
                // Either the project or the situation
                if (widget.user.builder?.project != null)
                  _buildInfo(context, "Projet", widget.user.builder!.project!.name)
                else 
                  _buildInfo(context, "Situation", widget.user.situation)
              ],
            ),
          ),
        ),
        const SizedBox(height: 20,),

        // The choices
        Flexible(
          child: Row(
            children: [
              // Status choice
              Expanded(
                child: BuDropdown<String>(
                  items: UserStatus.detailled,
                  currentValue: _currentUserStatus,
                  label: "état",
                  onChanged: (value) {
                    setState(() {
                      _currentUserStatus = value ?? "UNKNOWN";
                    });
                  },
                ),
              ),
              const SizedBox(width: 20,),

              // Step choice
              Expanded(
                child: BuDropdown<String>(
                  items: widget.user.role == UserRoles.builder 
                    ? BuilderSteps.detailled
                    : CoachSteps.detailled, 
                  currentValue: _currentUserStep,
                  label: "étape",
                  onChanged: (value) {
                    setState(() {
                      _currentUserStep = value ?? "UNKNOWN";
                    });
                  },   
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildInfo(BuildContext context, String title, String content) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1!.color,
          fontSize: 16,
          fontWeight: FontWeight.w600
        ),
        text: "$title :\n",
        children: [
          TextSpan(
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1!.color,
              fontSize: 16,
              fontWeight: FontWeight.w400
            ),
            text: content
          )
        ]
      ),
    );
  }

  void _onSubmit() {
    // Some safeguard
    if (
      _currentUserStep == BuilderSteps.active 
    ) {
      _currentUserStatus = UserStatus.validated;
    }

    Navigator.of(context).pop(<String, dynamic>{
      "id": widget.user.id!,
      "status": _currentUserStatus,
      "step": _currentUserStep
    });
  }
}