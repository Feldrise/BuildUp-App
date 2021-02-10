import 'package:buildup/src/providers/coach_store.dart';
import 'package:buildup/src/shared/widgets/general/bu_button.dart';
import 'package:buildup/src/shared/widgets/inputs/bu_checkbox.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoachValidatedCandidature extends StatefulWidget {
  const CoachValidatedCandidature({Key key, @required this.onSigned}) : super(key: key);

  final Function() onSigned;

  @override
  _CoachValidatedCandidatureState createState() => _CoachValidatedCandidatureState();
}

class _CoachValidatedCandidatureState extends State<CoachValidatedCandidature> {
  bool _hasApproved = false;
  bool _hasSigned = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Objet : Attestation de participation au programme", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 32,),
        _buildText(),
        const SizedBox(height: 16,),
        _buildSigningInfo(),
        const SizedBox(height: 16,),
        BuButton(
          text: "Terminer", 
          onPressed: (_hasSigned && _hasApproved) ? _submitSign : null
        )
      ],
    );
  }

  Widget _buildText() {
    return Consumer<CoachStore>(
      builder: (context, coachStore, child) {
        return RichText(
          text: TextSpan(
            text: 'Je soussigné(e) Mr/Mme ',
            style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(text: coachStore.coach.associatedUser.fullName, style: const TextStyle(color: colorPrimary)),
                const TextSpan(text: ", né(e) le "),
                TextSpan(text: coachStore.coach.associatedUser.birthdate.toString(), style: const TextStyle(color: colorPrimary)),
                const TextSpan(text: ", atteste sur l’honneur avoir pris connaissance des engagements relatifs au rôle de Coach au sein du programme, être prêt à faire évoluer le projet de mon Builder, à lui accorder du temps et de la bienveillance, être à l’écoute de ses problématiques et proposer des solutions et pour finir partager votre expérience avec passion.\n\n"),
                const TextSpan(text: "J’ai connaissance de l’investissement qui m’est demandé, j’ai la volonté de faire grandir autant personnellement que profesionnellement mon Builder et lui donner les clés pour faire évoluer son projet.\n\n\n"),
                const TextSpan(text: "Fait le "),
                TextSpan(text: DateTime.now().toString(), style: const TextStyle(color: colorPrimary)),
                
              ],
            ),
          );
      }
    );
  }

  Widget _buildSigningInfo() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: colorGreyBackground,
        ),
        borderRadius: BorderRadius.circular(8.0)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("En signant cette fiche d’intégration, vous vous engagez à :", style: TextStyle(color: colorPrimary),),
          const SizedBox(height: 8,),
          _buildCheck("Faire preuve de pédagogie, de bienveillance, d’écoute et de respect envers votre Builder."),
          _buildCheck("Garantir au moins 3 à 4 entretiens par mois à votre Builder. De manière optimale, un entretien par semaine serait souhaité. Le temps alloué à cet entretien est à déterminer avec votre Builder."),
          _buildCheck("Assister à l’entretien de mi-parcours avec le membre de l’équipe référent (celui qui a pris en charge l’inscription du Builder concerné)."),
          _buildCheck("Être disponible pour répondre aux questions de votre Builder et l’assister dans ses recherches  si vous n’avez pas es réponses."),
          _buildCheck("Suivre l’évolution sous 3 mois de votre Builder. Cette évolution peut se caractériser par les paliers que nous proposons (Les Build On) ou selon vos propres perspectives. Vous êtes libre d’établir votre propre planning."),
          _buildCheck("Être franc. Si vous pensez que certaines idées ou pensées de votre Builder ne sont pas cohérentes ou manque de crédibilité, ne pas hésiter à lui dire. La relation développée doit être de confiance !"),
          const SizedBox(height: 16,), 
          BuCheckBox(
            value: _hasApproved, 
            onChanged: (value) {
              setState(() {
                _hasApproved = value;
              });
            }, 
            text: "Lu et approuvé"
          ),
          const SizedBox(height: 8,), 
          BuCheckBox(
            value: _hasSigned, 
            onChanged: (value) {
              setState(() {
                _hasSigned = value;
              });
            }, 
            text: "En cochant cette case, je signe le document présenté ci-contre et j’atteste de mon engagement au programme ainsi que la véracité des informations présentées."
          ),
        ],
      ),
    );
  }

  Widget _buildCheck(String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check, color: colorPrimary, size: 20,),
          const SizedBox(width: 4,),
          Flexible(child: Text(info))
        ],
      ),
    );
  }

  Future _submitSign() async {
    if (_hasApproved && _hasSigned) {
      await widget.onSigned();
    }
  }
}