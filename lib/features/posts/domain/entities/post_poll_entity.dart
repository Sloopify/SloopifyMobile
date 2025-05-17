import 'package:equatable/equatable.dart';
import 'package:flutter_polls/flutter_polls.dart';

class PostPollEntity extends Equatable {
  final String id;
final List<PollOption> pollOptions;

  PostPollEntity({
    required this.id,
required this.pollOptions
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, pollOptions, ];
}
