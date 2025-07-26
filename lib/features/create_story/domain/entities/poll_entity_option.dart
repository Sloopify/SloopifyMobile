class PollOption {
   int optionId;
   String optionName;
  int votes;

  PollOption({
    required this.optionId,
    required this.optionName,
    this.votes = 0,
  });

  Map<String, dynamic> toJson() => {
    'option_id': optionId,
    'option_name': optionName,
    'votes': votes,
  };

  factory PollOption.fromEmpty() {
    return PollOption(optionId: -1, optionName: '', votes: 0);
  }
}

class Poll {
  final String question;
  final List<PollOption> options;

  Poll({required this.question, required this.options});

  Map<String, dynamic> toJson() => {
    'question': question,
    'poll_options': options.map((option) => option.toJson()).toList(),
  };

  factory Poll.fromEmpty() {
    return Poll(question: "", options: []);
  }
}
