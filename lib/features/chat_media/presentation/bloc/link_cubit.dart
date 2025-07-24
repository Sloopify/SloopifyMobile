import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/chat_media/data/models/link_model.dart';

class LinkCubit extends Cubit<List<LinkModel>> {
  List<LinkModel> _allLinks = [];

  LinkCubit() : super([]);

  void loadLinks() {
    _allLinks = [
      LinkModel(
        url: 'https://m.facebook.com/story.php?story_fbid=df23a...',
        domain: 'm.facebook.com',
      ),
      LinkModel(
        url: 'https://m.facebook.com/story.php?story_fbid=df23a...',
        domain: 'm.facebook.com',
      ),
      LinkModel(
        url: 'https://m.facebook.com/story.php?story_fbid=df23a...',
        domain: 'm.facebook.com',
      ),
      LinkModel(
        url: 'https://m.facebook.com/story.php?story_fbid=df23a...',
        domain: 'm.facebook.com',
      ),
    ];
    emit(_allLinks);
  }

  void searchLinks(String query) {
    if (query.isEmpty) {
      emit(_allLinks);
    } else {
      emit(
        _allLinks
            .where(
              (link) => link.url.toLowerCase().contains(query.toLowerCase()),
            )
            .toList(),
      );
    }
  }
}
