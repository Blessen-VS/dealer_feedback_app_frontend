import 'dart:html' as html; // Required for web file upload
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FileUploadComponent extends StatelessWidget {
  final ValueChanged<String> onFileSelected;

  const FileUploadComponent({Key? key, required this.onFileSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        if (kIsWeb) {
          // Web-specific file picker
          final html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
          uploadInput.accept = '.pdf,.jpg,.jpeg,.png'; // Allowed file types
          uploadInput.click();

          uploadInput.onChange.listen((e) async {
            final files = uploadInput.files;
            if (files!.isNotEmpty) {
              final reader = html.FileReader();
              reader.readAsDataUrl(files[0]);
              reader.onLoadEnd.listen((_) {
                onFileSelected(reader.result as String); // Data URL
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('File Selected: ${files[0].name}')),
                );
              });
            }
          });
        } else {
          // Non-web file picker
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
          );
          if (result != null) {
            onFileSelected(result.files.single.path ?? '');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('File Selected: ${result.files.single.name}')),
            );
          }
        }
      },
      icon: Icon(Icons.upload_file),
      label: Text('Choose File'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
