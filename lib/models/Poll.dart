class Poll {
  String question;
  List<PollOption> options;
  String id;

  Poll({this.id, this.question, this.options});
}

class PollOption {
  String answer;

  PollOption({this.answer});
}
