import 'package:buildup/entities/ntf_referent.dart';
import 'package:buildup/src/shared/widgets/general/bu_card.dart';
import 'package:buildup/src/shared/widgets/general/bu_icon_button.dart';
import 'package:flutter/material.dart';

class AdminNtfReferentCard extends StatelessWidget {
  const AdminNtfReferentCard({
    Key key, 
    @required this.ntfReferent,
    @required this.onUpdate,
    @required this.onDelete,
  }) : super(key: key);

  final NtfReferent ntfReferent;

  final Function() onUpdate;
  final Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return BuCard(
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTitle(context),
          Container(
            color: Theme.of(context).dividerColor,
            height: 1,
          ),
          Wrap(
            children: [
              _buildSmallInfo("Email", ntfReferent.email, maxWidth: 300),
              _buildSmallInfo("Tag Discord", ntfReferent.discordTag)
            ],
          )
        ],
      )
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Expanded(
            child: Text(ntfReferent.name, style: Theme.of(context).textTheme.headline6,),
          ),
          BuIconButton(
            icon: Icons.edit, 
            onPressed: onUpdate
          ),
          const SizedBox(width: 10,),
          BuIconButton(
            icon: Icons.delete_forever,
            onPressed: onDelete
          )
        ],
      ),
    );
  }

  Widget _buildSmallInfo(String title, String info, {double maxWidth = 200}) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title.toUpperCase(), style: const TextStyle(fontSize: 12, color: Color(0xff919191)),),
            const SizedBox(height: 5,),
            Text(info)
          ],
        ),
      ),
    ); 
  }
}