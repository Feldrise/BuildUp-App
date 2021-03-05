
import 'package:buildup/src/pages/coachs/coach_dashboard_page/widgets/coach_notifications_widget.dart';
import 'package:buildup/src/providers/coach_store.dart';
import 'package:buildup/src/shared/widgets/general/discord_button.dart';
import 'package:buildup/src/shared/widgets/general/whatsapp_button.dart';
import 'package:buildup/utils/colors.dart';
import 'package:buildup/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoachDashboardPage extends StatelessWidget {
  const CoachDashboardPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = ScreenUtils.instance.horizontalPadding;

    return Consumer<CoachStore>(
      builder: (context, coachStore, child) {
        return Scaffold(
          backgroundColor: colorScaffoldGrey,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: horizontalPadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text("“Je suis une citation” _- Guillaume Pas Ordinair", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: colorGreyText)),
                  const SizedBox(height: 24,),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth < 900) {
                        return Column(
                          children: [
                            CoachNotificationsWidget(),
                            const SizedBox(height: 16,),
                            _buildDashboardMainColumn(context, coachStore)
                          ],
                        );
                      }
                      else {
                        return Row(
                          children: [
                            Expanded(
                              child: _buildDashboardMainColumn(context, coachStore),
                            ),
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 350),
                              child: CoachNotificationsWidget(),
                            )
                          ],
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          )
        );
      },
    );
  }

  Widget _buildDashboardMainColumn(BuildContext context, CoachStore coachStore) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 309),
              child: DiscordButton()
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 309),
              child: WhatsappButton()
            ),
          ],
        )
      ],
    );
  }
}