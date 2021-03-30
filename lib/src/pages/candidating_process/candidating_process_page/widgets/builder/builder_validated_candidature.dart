
import 'package:buildup/src/providers/builder_store.dart';
import 'package:buildup/src/shared/widgets/general/bu_button.dart';
import 'package:buildup/src/shared/widgets/inputs/bu_checkbox.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BuilderValidatedCandidature extends StatefulWidget {
  const BuilderValidatedCandidature({Key? key, required this.onSigned}) : super(key: key);

  final Function() onSigned;

  @override
  _BuilderValidatedCandidatureState createState() => _BuilderValidatedCandidatureState();
}

class _BuilderValidatedCandidatureState extends State<BuilderValidatedCandidature> {
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
        Row(
          children: [
            Expanded(child: Container(),),
            BuButton(
              text: "Terminer", 
              isBig: true,
              onPressed: (_hasSigned && _hasApproved) ? _submitSign : null
            ),
          ],
        )
      ],
    );
  }

  Widget _buildText() {
    return Consumer<BuilderStore>(
      builder: (context, builderStore, child) {
        return RichText(
          text: TextSpan(
            text: 'Je soussigné(e) Mr/Mme ',
            style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(text: builderStore.builder!.associatedUser.fullName, style: const TextStyle(color: colorPrimary)),
                const TextSpan(text: ", né(e) le "),
                TextSpan(text: DateFormat('dd/MM/yyyy').format(builderStore.builder!.associatedUser.birthdate), style: const TextStyle(color: colorPrimary)),
                const TextSpan(text: ", atteste sur l’honneur avoir pris connaissance des engagements relatifs au rôle de Builder au sein du programme, être prêt à faire évoluer mon projet et ma personnalité suivant les conseils de mon Coach et ceux de l’équipe NTF et enfin être conscient que le programme implique une présence et une activité constante durant les trois prochains mois.\n\n"),
                const TextSpan(text: "J’ai connaissance de l’investissement qui m’est demandé, j’ai la volonté d’aller plus loin et d’être toujours à l’écoute de mon Coach avec bienveillance, sourire et bonne humeur.\n\n\n"),
                const TextSpan(text: "Fait le "),
                TextSpan(text: DateFormat('dd/MM/yyyy').format(DateTime.now()), style: const TextStyle(color: colorPrimary)),
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
          _buildCheck("Être disponible et engagé(e) dans le développement de mon projet."),
          _buildCheck("Être à l’écoute des conseils de mon Coach et les mettre en pratique."),
          _buildCheck("Actualiser ma situation avec l’équipe et se présenter aux entretiens."),
          _buildCheck("Prévenir l’équipe NTF et mon Coach en cas d’absence de longue durée."),
          _buildCheck("Faire preuve de bienveillance et d’entraide à l’écart des autres Builders."),
          _buildCheck("Participer aux workshops et présentations que l’équipe NTF organise (si ce n’est pas possible, prévenir)."),
          _buildCheck("Donner son avis régulièrement sur le programme et surtout sur son Coach (sa présence, son relationnel...)."),
          _buildCheck("Donner de mes nouvelles en cas de coup de mou que ce soit à mon Coach ou à l’équipe NTF. Nous sommes là pour ça aussi !"),
          const SizedBox(height: 16,), 
          BuCheckBox(
            value: _hasApproved, 
            onChanged: (value) {
              setState(() {
                _hasApproved = value ?? false;
              });
            }, 
            text: "Lu et approuvé"
          ),
          const SizedBox(height: 8,), 
          BuCheckBox(
            value: _hasSigned, 
            onChanged: (value) {
              setState(() {
                _hasSigned = value ?? false;
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