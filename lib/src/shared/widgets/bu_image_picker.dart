import 'package:buildup/entities/bu_image.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/src/shared/widgets/bu_button.dart';
import 'package:buildup/src/shared/widgets/bu_icon_button.dart';
import 'package:buildup/utils/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuImagePicker extends StatefulWidget {
  const BuImagePicker({Key key, @required this.image, this.onUpdated}) : super(key: key);

  final BuImage image;

  final Function() onUpdated;

  @override
  _BuImagePickerState createState() => _BuImagePickerState();
}

class _BuImagePickerState extends State<BuImagePicker> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserStore>(
      builder: (context, userStore, child) {
        return  FutureBuilder(
          future: widget.image.loadImageFromSource(userStore.authentificationHeader),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return _buildFullImagePicker();
              }
              
              return _buildEmptyImagePicker();
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

  Widget _buildEmptyImagePicker() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 44, horizontal: 44),
      color: const Color(0xfff5f5f6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Image", style: TextStyle(color: Color(0xff949c9e)),),
          const SizedBox(height: 16,),
          BuButton(
            text: "Ajouter une image", 
            onPressed: _selectImage
          )
        ],
      ),
    );
  }

  Widget _buildFullImagePicker() {
    return Container(
      height: 232,
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image(
              image: widget.image.image,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BuIconButton(
                backgroundColor: colorPrimary,
                icon: Icons.edit, 
                onPressed: _selectImage
              ),
            ),
          )
        ],
      ),
    );
  }

  Future _selectImage() async {
    final FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.image
    );

    if (result != null) {
      final PlatformFile file = result.files.first;
      widget.image.image = MemoryImage(file.bytes);
      widget.image.isImageEvenWithServer = false;
      setState(() {});

      if (widget.onUpdated != null) {
        widget.onUpdated();
      }
    }
  }
}