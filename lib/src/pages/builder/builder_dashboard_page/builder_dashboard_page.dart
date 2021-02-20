import 'package:buildup/src/pages/builder/builder_dashboard_page/widgets/builder_buildon_step_dashboard_card.dart';
import 'package:buildup/src/pages/builder/builder_dashboard_page/widgets/builder_coach_dashboard_card.dart';
import 'package:buildup/src/pages/builder/builder_dashboard_page/widgets/builder_notification_widget.dart';
import 'package:buildup/src/pages/builder/builder_dashboard_page/widgets/builder_referent_dashboard_card.dart';
import 'package:buildup/src/providers/builder_store.dart';
import 'package:buildup/src/shared/widgets/general/discord_button.dart';
import 'package:buildup/src/shared/widgets/general/whatsapp_button.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuilderDashboardPage extends StatelessWidget {
  const BuilderDashboardPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BuilderStore>(
      builder: (context, builderStore, child) {
        return Scaffold(
          backgroundColor: colorScaffoldGrey,
          body: Navigator(
            key: GlobalKey<NavigatorState>(),
            onGenerateRoute: (route) => MaterialPageRoute<void>(
              settings: route,
              builder: (context) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
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
                                  BuilderNotificationWidget(),
                                  const SizedBox(height: 16,),
                                  _buildDashboardMainColumn(context, builderStore)
                                ],
                              );
                            }
                            else {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: _buildDashboardMainColumn(context, builderStore),
                                  ),
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(maxWidth: 350),
                                    child: BuilderNotificationWidget(),
                                  )
                                ],
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                );
              }
            ),
          )
        );
      },
    );
  }

  Widget _buildDashboardMainColumn(BuildContext context, BuilderStore builderStore) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double cardsWidth  = constraints.maxWidth > 616 ? 300 : constraints.maxWidth;

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                SizedBox(
                  width: cardsWidth,
                  child: BuilderReferentDashboardCard(),
                ),
                SizedBox(
                  width: cardsWidth,
                  child: BuilderCoachDashboardCard(),
                ),
                SizedBox(
                  width: cardsWidth,
                  child: BuilderBuildOnDashboardCard(),
                ),
                SizedBox(
                  width: cardsWidth,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DiscordButton(),
                      const SizedBox(height: 16,),
                      WhatsappButton()
                    ],
                  ),
                )
              ],
            )
          ],
        );
      },
    );
  }
}