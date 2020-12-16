import 'dart:typed_data';

class BuFile {
  String id;
  String fileName;
  Uint8List data;
  
  BuFile(this.id, {
    this.fileName = "",
    this.data
  });
}