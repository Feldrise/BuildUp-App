import 'package:buildup/entities/available_coach.dart';
import 'package:buildup/services/coachs_services.dart';
import 'package:buildup/src/pages/candidating_process/candidating_process_page/widgets/builder/available_coach_widget/available_coach_card.dart';
import 'package:buildup/src/providers/builder_store.dart';
import 'package:buildup/src/shared/widgets/general/bu_button.dart';
import 'package:buildup/src/shared/widgets/general/bu_status_message.dart';
import 'package:buildup/src/shared/widgets/inputs/bu_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvailableCoachWidget extends StatefulWidget {
  const AvailableCoachWidget({Key? key, required this.onCoachValidated}) : super(key: key);

  final Function(AvailableCoach) onCoachValidated;

  @override
  _AvailableCoachWidgetState createState() => _AvailableCoachWidgetState();
}

class _AvailableCoachWidgetState extends State<AvailableCoachWidget> {
  AvailableCoach? _selectedCoach;
  bool _coachContacted = false;

  List<AvailableCoach>? _availableCoachs;
  
  @override
  Widget build(BuildContext context) {
    return Consumer<BuilderStore>(
      builder: (context, builderStore, child) {
        return FutureBuilder(
          future: getAvailableCoachs(builderStore.builder!.associatedUser.authentificationHeader),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return BuStatusMessage(
                  title: "Erreur",
                  message: "Une erreur s'est produite durant la récupération des coaches disponible... ${snapshot.error.toString()}",
                );
              }

              final List<AvailableCoach> availableCoachs = snapshot.data as List<AvailableCoach>;

              return Column(
                children: [
                  _buildCoachWrap(availableCoachs),
                  const SizedBox(height: 16,),
                  BuCheckBox(
                    value: _coachContacted, 
                    onChanged: (value) {
                      setState(() {
                        _coachContacted = value ?? false;
                      });
                    }, 
                    text: "En cochant cette case, j’atteste avoir contacté le coach et obtenu son approbation."
                  ),
                  const SizedBox(height: 16,),
                  Row(
                    children: [
                      Expanded(child: Container(),),
                      BuButton(
                        text: "Valider mon choix", 
                        isBig: true,
                        onPressed: _selectedCoach != null && _coachContacted ? () => widget.onCoachValidated(_selectedCoach!) : null
                      ),
                    ],
                  )
                ],
              );
            }

            return Container(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    SizedBox(
                      width: 84,
                      height: 84,
                      child: CircularProgressIndicator()
                    ),
                    SizedBox(height: 30,),
                    Text("Récupération des coachs disponibles...")
                  ]
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCoachWrap(List<AvailableCoach> coachs) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Wrap(
          children: [
            for (final coach in coachs) ...{
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: AvailableCoachCard(
                  coach: coach,
                  width: constraints.maxWidth > 505 ? 300 : constraints.maxWidth,
                  isSelected: coach == _selectedCoach,
                  onCoachSelected: (coach) {
                    setState(() {
                      _selectedCoach = coach;
                    });
                  },
                ),
              ),
            }
          ],
        );
      },
    );
  }

  Future<List<AvailableCoach>> getAvailableCoachs(String authenticationHeaders) async {
    return _availableCoachs ??= await CoachsService.instance.getAvailableCoachs(authenticationHeaders);
  }
}