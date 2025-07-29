class PollOption {
  int optionId;
  String optionName;
  int votes;

  PollOption({
    required this.optionId,
    required this.optionName,
    this.votes = 0,
  });

  Map<String, dynamic> toJson() =>
      {
        'option_id': optionId,
        'option_name': optionName,
        'votes': votes,
      };

  factory PollOption.fromEmpty() {
    return PollOption(optionId: -1, optionName: '', votes: 0);
  }

  factory PollOption.fromJson(Map<String, dynamic>json){
    return PollOption(optionId: int.parse(json["option_id"]),
        optionName: json["option_name"]);
  }
}

class Poll {
  final String question;
  final List<PollOption> options;

  Poll({required this.question, required this.options});

  Map<String, dynamic> toJson() =>
      {
        'question': question,
        'poll_options': options.map((option) => option.toJson()).toList(),
      };

  factory Poll.fromJson(Map<String, dynamic> json){
    return Poll(question: json["question"], options: List.generate(
      json["options"].length,
          (index) =>  PollOption.fromJson(json["options"][index]),
    ));
  }

  factory Poll.fromEmpty() {
    return Poll(question: "", options: []);
  }
}
