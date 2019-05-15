class EventAttendantsOverview {
  int _invited;
  int _going;
  int _maybe;
  int _rejected;

  EventAttendantsOverview(int invited, int going, int maybe, int rejected) {
    _invited = invited;
    _going = going;
    _maybe = maybe;
    _rejected = rejected;
  }

  int get going => _going;

  int get invited => _invited;

  int get maybe => _maybe;

  int get rejected => _rejected;
}
