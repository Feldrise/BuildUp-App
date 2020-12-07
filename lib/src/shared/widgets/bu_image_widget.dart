import 'package:buildup/entities/bu_image.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuImageWidget extends StatelessWidget {
  const BuImageWidget({Key key, @required this.image, this.isCircular = false}) : super(key: key);

  final BuImage image;
  final bool isCircular;

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
              color: const Color(0xfff5f5f6),
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 50),
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
    return LayoutBuilder(
      builder: (context, constraint) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(isCircular ? constraint.maxWidth / 2 : 0),
          child: Image(
            image: image.image,
            fit: BoxFit.cover,
          ),
        );
      }
    );
  }

  Widget _buildEmptyImage() {
    return LayoutBuilder(
      builder: (context, constraint) {
        if (isCircular) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(constraint.maxWidth / 2),
            child: Image.asset(
              "icons/icon_profile_picture.png",
              fit: BoxFit.cover,
            ),
          );
        }

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          color: const Color(0xfff5f5f6),
          child: const Center(
            child: Text("Image Vide", textAlign: TextAlign.center, style: TextStyle(color: Color(0xff949c9e)),),
          )
        );
      }
    );
  }
}