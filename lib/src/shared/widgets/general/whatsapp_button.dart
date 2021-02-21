
import 'package:buildup/src/shared/widgets/general/bu_card.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsappButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launch("https://whatsapp.new-talents.fr"),
      child: BuCard(
        child: Row(
         children: [
           Image.asset("assets/icons/whatsapp.png", width: 40, height: 40,),
           const SizedBox(width: 4),
           const Expanded(
             child: Text("Rejoindre le groupe WhatsApp"),
           )
         ],
        ),
      ),
    );
  }
}