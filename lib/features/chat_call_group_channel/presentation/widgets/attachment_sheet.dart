import 'package:flutter/material.dart';

class AttachmentSheet extends StatelessWidget {
  const AttachmentSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        children: [
          _attachmentTile(Icons.camera_alt, 'Camera', () {}),
          _attachmentTile(Icons.photo, 'Gallery', () {}),
          _attachmentTile(Icons.audiotrack, 'Audio', () {}),
          _attachmentTile(Icons.insert_drive_file, 'Document', () {}),
          _attachmentTile(Icons.shutter_speed, 'One-time Photo', () {}),
          _attachmentTile(Icons.music_note, 'One-time Audio', () {}),
        ],
      ),
    );
  }

  Widget _attachmentTile(IconData icon, String label, VoidCallback onTap) {
    return ListTile(leading: Icon(icon), title: Text(label), onTap: onTap);
  }
}
