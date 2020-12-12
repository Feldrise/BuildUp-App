import 'package:buildup/entities/builder.dart';
import 'package:buildup/services/builders_service.dart';
import 'package:buildup/src/pages/administration/admin_candidating_pages/admin_builders_candidating_page/widgets/admin_candidating_builder_card.dart';
import 'package:buildup/src/providers/candidating_builders_store.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/src/shared/widgets/bu_status_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AdminBuildersCandidatingPage extends StatefulWidget {
  const AdminBuildersCandidatingPage({Key key}) : super(key: key);

  @override
  _AdminBuildersCandidatingPageState createState() => _AdminBuildersCandidatingPageState();
}

class _AdminBuildersCandidatingPageState extends State<AdminBuildersCandidatingPage> {
  bool _hasError = false;
  String _statusMessage = "";

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _refresh(context),
      child: Stack(
        children: [
          ListView(), // Here to make the RefreshIndicator working
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_hasError)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                  child: BuStatusMessage(
                    title: "Erreur",
                    message: _statusMessage,
                  ),
                ),
              Consumer<CandidatingBuilderStore>(
                builder: (context, candidatingBuildersStore, child) {
                  if (!candidatingBuildersStore.hasData) {
                    return const Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: BuStatusMessage(
                          type: BuStatusMessageType.info,
                          message: "Il n'y a aucun builder candidatant pour le moment",
                        ),
                      ),
                    );
                  }
                  
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (final BuBuilder builder in candidatingBuildersStore.builders) ...{
                          AdminCandidatingBuilderCard(builder: builder),
                          const SizedBox(height: 15,)
                        }
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future _refresh(BuildContext context) async {
    final CandidatingBuilderStore candidatingBuilderStore = Provider.of<CandidatingBuilderStore>(context, listen: false);
    final UserStore currentUser = Provider.of<UserStore>(context, listen: false);

    try {
      candidatingBuilderStore.builders = await BuildersService.instance.getCandidatingBuilders(currentUser.authentificationHeader);

      setState(() {
        _hasError = false;
        _statusMessage = "";
      });
    }
    on PlatformException catch(e) {
      setState(() {
        _hasError = true;
        _statusMessage = "Erreur lors du rafraîchissement : ${e.message}";
      });
    }
    on Exception catch(e) {
      setState(() {
        _hasError = true;
        _statusMessage = "Erreur lors du rafraîchissement : $e";
      });
    }
  }
}