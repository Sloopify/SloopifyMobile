import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/document_model.dart';

class ChatFriendCubit extends Cubit<List<DocumentModel>> {
  ChatFriendCubit() : super([]);

  void loadDocuments() {
    emit(_mockDocuments);
  }

  static final List<DocumentModel> _mockDocuments = [
    DocumentModel(
      name: 'document name.pdf',
      size: '2.2 MB',
      type: 'PDF',
      date: '2025/5/13',
      iconAsset: 'assets/icons/profile_info/pdf_icon.png',
    ),
    DocumentModel(
      name: 'document name.pdf',
      size: '2.2 MB',
      type: 'PDF',
      date: '2025/5/13',
      iconAsset: 'assets/icons/profile_info/pdf_icon.png',
    ),
    DocumentModel(
      name: 'document name.pdf',
      size: '2.2 MB',
      type: 'PDF',
      date: '2025/5/13',
      iconAsset: 'assets/icons/profile_info/pdf_icon.png',
    ),
  ];
}
