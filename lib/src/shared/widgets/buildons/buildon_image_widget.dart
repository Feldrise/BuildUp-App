
import 'package:buildup/entities/bu_image.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum BuildOnImageRoundedCorner { onlyTopLeft, onlyTop, none }

class BuildOnImageWidget extends StatelessWidget {
  const BuildOnImageWidget({
    Key key, 
    @required this.image,
    this.corners = BuildOnImageRoundedCorner.onlyTopLeft,  
  }) : super(key: key);

  final BuImage image;
  final BuildOnImageRoundedCorner corners;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserStore>(
      builder: (context, userStore, child) {
        return  FutureBuilder(
          future: image.loadImageFromSource(userStore.authentificationHeader),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return _buildImage();
              }
              
              return _buildEmptyImage();
            }

            return Container(
              decoration: BoxDecoration(
                color: const Color(0xfff5f5f6),
                borderRadius: corners == BuildOnImageRoundedCorner.none ? BorderRadius.circular(0) : BorderRadius.only(
                  topLeft: const Radius.circular(8),
                  topRight: (corners == BuildOnImageRoundedCorner.onlyTopLeft) ? Radius.zero : const Radius.circular(8)
                ),
              ),
              height: 200,
              padding: const EdgeInsets.all(8.0),
              child: const Center(
                child: CircularProgressIndicator(),
              )
            );
          },
        );
      }
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: corners == BuildOnImageRoundedCorner.none ? BorderRadius.circular(0) : BorderRadius.only(
        topLeft: const Radius.circular(8),
        topRight: (corners == BuildOnImageRoundedCorner.onlyTopLeft) ? Radius.zero : const Radius.circular(8)
      ),
      child: Image(
        image: image.image,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildEmptyImage() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      height: 200,
      decoration: BoxDecoration(
        color: const Color(0xfff5f5f6),
        borderRadius: corners == BuildOnImageRoundedCorner.none ? BorderRadius.circular(0) : BorderRadius.only(
          topLeft: const Radius.circular(8),
          topRight: (corners == BuildOnImageRoundedCorner.onlyTopLeft) ? Radius.zero : const Radius.circular(8)
        ),
      ),
      child: const Center(
        child: Text("Image Vide", textAlign: TextAlign.center, style: TextStyle(color: Color(0xff949c9e)),),
      )
    );
  }
}