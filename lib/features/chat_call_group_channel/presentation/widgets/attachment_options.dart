import 'package:flutter/material.dart';

class AttachmentOptions extends StatelessWidget {
  const AttachmentOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 20,
        children: [
          _option(context, Icons.photo, "Gallery", onGalleryTap),
          _option(context, Icons.camera_alt, "Camera", onCameraTap),
          _option(context, Icons.mic, "Audio", onAudioTap),
          _option(context, Icons.insert_drive_file, "Document", onDocumentTap),
        ],
      ),
    );
  }

  Widget _option(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(child: Icon(icon)),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }

  void onGalleryTap() {
    // dispatch GalleryPickedEvent in BLoC
  }

  void onCameraTap() {
    // navigate to camera screen
  }

  void onAudioTap() {
    // dispatch RecordAudioEvent or show audio recorder
  }

  void onDocumentTap() {
    // dispatch DocumentPickedEvent
  }
}
