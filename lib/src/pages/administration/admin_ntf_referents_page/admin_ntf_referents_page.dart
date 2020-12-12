import 'package:buildup/entities/ntf_referent.dart';
import 'package:buildup/src/pages/administration/admin_ntf_referents_page/dialogs/admin_ntf_referent_delete_dialog.dart';
import 'package:buildup/src/pages/administration/admin_ntf_referents_page/dialogs/admin_ntf_referent_dialog.dart';
import 'package:buildup/src/pages/administration/admin_ntf_referents_page/widgets/admin_ntf_referent_card.dart';
import 'package:buildup/src/providers/ntf_referents_store.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/src/shared/dialogs/dialogs.dart';
import 'package:buildup/src/shared/widgets/bu_status_message.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AdminNtfReferentsPage extends StatefulWidget {
  @override
  _AdminNtfReferentsPageState createState() => _AdminNtfReferentsPageState();
}

class _AdminNtfReferentsPageState extends State<AdminNtfReferentsPage> {
  bool _hasError = false;
  String _statusMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScaffoldGrey,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_statusMessage.isNotEmpty) ...{ 
              BuStatusMessage(
                type: _hasError ? BuStatusMessageType.error : BuStatusMessageType.success,
                title: _hasError ? "Erreur" : "Bravo !",
                message: _statusMessage,
              ),
              const SizedBox(height: 15),
            },
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final double cardMaxWidth = constraints.maxWidth > 411 ? (constraints.maxWidth - 15) / 2 : constraints.maxWidth;

                  return Consumer2<NtfReferentsStore, UserStore>(
                    builder: (context, ntfReferentsStore, userStore, child) {
                      return FutureBuilder(
                        future: ntfReferentsStore.ntfReferents(userStore.authentificationHeader),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            if (snapshot.hasError) {
                              return Center(
                                child: BuStatusMessage(
                                  title: "Erreur lors de la récupération des référents NTF",
                                  message: snapshot.error.toString(),
                                ),
                              );
                            }

                            if (!snapshot.hasData) {
                              return const Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 30),
                                  child: BuStatusMessage(
                                    type: BuStatusMessageType.info,
                                    message: "Il n'y a aucun référent pour le moment",
                                  ),
                                ),
                              );
                            }

                            final List<NtfReferent> referents = snapshot.data as List<NtfReferent>;

                            return Wrap(
                              spacing: 15,
                              runSpacing: 15,
                              children: [
                                for (final referent in referents)
                                  SizedBox(
                                    width: cardMaxWidth,
                                    child: AdminNtfReferentCard(
                                      ntfReferent: referent,
                                      onUpdate: () => _updateReferent(referent, ntfReferentsStore, userStore),
                                      onDelete: () => _deleteReferent(referent, ntfReferentsStore, userStore),
                                    ),
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
                                  Text("Récupération des données des référents NTF")
                                ]
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorPrimary,
        onPressed: _addNewReferent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
  
  Future _deleteReferent(NtfReferent ntfReferent, NtfReferentsStore ntfReferentsStore, UserStore userStore) async {
    final bool shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AdminNtfReferentDeleteDialog(ntfReferent: ntfReferent)
    );

    if (shouldDelete != null && shouldDelete) {
      final GlobalKey<State> keyLoader = GlobalKey<State>();
      Dialogs.showLoadingDialog(context, keyLoader, "Suppression en cours"); 

      try {
        await ntfReferentsStore.removeReferent(userStore.authentificationHeader, ntfReferent);

        setState(() {
          _hasError = false;
          _statusMessage = "Le référent a bien été supprimé !";
        });
      } 
      on PlatformException catch(e) {
        setState(() {
          _hasError = true;
          _statusMessage = "Impossible de supprimer le référent : ${e.message}";
        });
      }
      on Exception catch(e) {
        setState(() {
          _hasError = true;
          _statusMessage = "Impossible de supprimer le référent : $e";
        });
      }

      Navigator.of(keyLoader.currentContext,rootNavigator: true).pop();
    }
  }
  
  Future _updateReferent(NtfReferent ntfReferent, NtfReferentsStore ntfReferentsStore, UserStore userStore) async {
    final bool shouldUpdate = await showDialog<bool>(
      context: context,
      builder: (context) => AdminNtfReferentDialog(ntfReferent: ntfReferent)
    );

    if (shouldUpdate != null && shouldUpdate) {
      final GlobalKey<State> keyLoader = GlobalKey<State>();
      Dialogs.showLoadingDialog(context, keyLoader, "Enregistrement en cours"); 

      try {
        await ntfReferentsStore.updateReferent(userStore.authentificationHeader, ntfReferent);

        setState(() {
          _hasError = false;
          _statusMessage = "Le référent a bien été modifié !";
        });
      } 
      on PlatformException catch(e) {
        setState(() {
          _hasError = true;
          _statusMessage = "Impossible de modifier le référent : ${e.message}";
        });
      }
      on Exception catch(e) {
        setState(() {
          _hasError = true;
          _statusMessage = "Impossible de modifier le référent : $e";
        });
      }

      Navigator.of(keyLoader.currentContext,rootNavigator: true).pop();
    }
  }

  Future _addNewReferent() async {
    final NtfReferentsStore ntfReferentsStore = Provider.of<NtfReferentsStore>(context, listen: false);
    final UserStore userStore = Provider.of<UserStore>(context, listen: false);

    if (ntfReferentsStore.loadedNtfReferents == null) {
      return;
    }

    final NtfReferent newReferent = NtfReferent(null);

    final bool shouldAdd = await showDialog<bool>(
      context: context,
      builder: (context) => AdminNtfReferentDialog(ntfReferent: newReferent)
    );

    if (shouldAdd != null && shouldAdd) {
      final GlobalKey<State> keyLoader = GlobalKey<State>();
      Dialogs.showLoadingDialog(context, keyLoader, "Enregistrement en cours"); 

      try {
        await ntfReferentsStore.addReferent(userStore.authentificationHeader, newReferent);

        setState(() {
          _hasError = false;
          _statusMessage = "Le référent a bien été ajouté !";
        });
      } 
      on PlatformException catch(e) {
        setState(() {
          _hasError = true;
          _statusMessage = "Impossible d'ajouter le référent : ${e.message}";
        });
      }
      on Exception catch(e) {
        setState(() {
          _hasError = true;
          _statusMessage = "Impossible d'ajouter le référent : $e";
        });
      }

      Navigator.of(keyLoader.currentContext,rootNavigator: true).pop();
    }
  }
}