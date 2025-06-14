import 'package:equatable/equatable.dart';

class PollEntity extends Equatable {
  final String question;
  final List<String> options;
  final bool multipleChoice;
  final bool showResultAfterVote;
  final bool showResultAfterEnd;
  final String endsAt;

  const PollEntity({
    required this.endsAt,
    required this.multipleChoice,
    required this.options,
    required this.question,
    required this.showResultAfterEnd,
    required this.showResultAfterVote,
  });

  @override
  // TODO: implement props
  List<Object?> get props =>[question,options,multipleChoice,showResultAfterEnd,showResultAfterVote,endsAt];
  toJson(){
    return {
      "question":question,
      "options":options,
      "multiple_choice":multipleChoice,
      "show_results_after_vote":showResultAfterVote,
      "show_results_after_end":showResultAfterEnd
    };
  }
}
