import 'package:buildup/src/shared/widgets/general/bu_button.dart';
import 'package:buildup/src/shared/widgets/general/bu_card.dart';
import 'package:buildup/src/shared/widgets/inputs/bu_textinput.dart';
import 'package:flutter/material.dart';

class SendNotificationCard extends StatefulWidget {
  const SendNotificationCard({
    Key? key, 
    required this.onSendNotification
  }) : super(key: key);

  final Function(String) onSendNotification;

  @override
  _SendNotificationCardState createState() => _SendNotificationCardState();
}

class _SendNotificationCardState extends State<SendNotificationCard> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _notificationTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BuCard(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BuTextInput(
              controller: _notificationTextController, 
              maxLines: 3,
              validator: (value) {
                if (value.isEmpty) {
                  return "Notifications can't be empty";
                }

                return null;
              }, 
              labelText: "Message à envoyer",
            ),
            const SizedBox(height: 15),
            _buildButtons()
          ],
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Wrap(
      spacing: 15,
      runSpacing: 15,
      alignment: WrapAlignment.end,
      crossAxisAlignment: WrapCrossAlignment.center,
      runAlignment: WrapAlignment.center,
      children: [
        BuButton(
          text: "Réinitialiser",
          buttonType: BuButtonType.secondary,
          onPressed: _reset 
        ),
        BuButton(
          text: "Envoyer",
          icon: Icons.send,
          onPressed: _sendNotification,
        )
      ],
    );
  }

  void _reset() {
    setState(() {
      _notificationTextController.text = "";
    });
  }

  Future _sendNotification() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      await widget.onSendNotification(_notificationTextController.text);

      setState(() {
        _notificationTextController.text = "";
      });
    }
  }
}