import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/media_item.dart';
import '../../domain/usecases/fetch_media_by_date.dart';
import 'chat_media_state.dart';

class ChatMediaCubit extends Cubit<ChatMediaState> {
  final FetchMediaByDate fetchMediaByDate;

  ChatMediaCubit(this.fetchMediaByDate) : super(ChatMediaState.initial());

  Future<void> loadMedia() async {
    try {
      final result = await fetchMediaByDate();
      emit(state.copyWith(mediaByDate: result));
    } catch (e) {
      emit(state.copyWith(mediaByDate: {}));
    }
  }
}
