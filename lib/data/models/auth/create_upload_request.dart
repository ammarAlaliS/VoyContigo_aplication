import 'dart:io';

class CreateUploadRequest {
  final String folder;
  final File imageFile;

  CreateUploadRequest({required this.folder, required this.imageFile});
}