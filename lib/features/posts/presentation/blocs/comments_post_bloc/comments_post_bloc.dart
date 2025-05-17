import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'comments_post_event.dart';
part 'comments_post_state.dart';

class CommentsPostBloc extends Bloc<CommentsPostEvent, CommentsPostState> {
  CommentsPostBloc() : super(CommentsPostInitial()) {
    on<GetCommentsForPost>((event, emit) {
      // TODO: implement event handler
    });
  }
}
