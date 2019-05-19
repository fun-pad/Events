import 'package:intl/intl.dart';

import 'EventAttendants.dart';
import 'EventImage.dart';
import 'EventState.dart';

class Event {
  String _name;
  DateTime _startDate;
  DateTime _endDate;
  EventState _state;
  String _description;
  EventAttendantsOverview _attendants;
  EventImage _image;
  String _id;

  Event(String id, String name, DateTime startDate, DateTime endDate, EventState state,
      String description, EventAttendantsOverview attendants, EventImage image) {
    _id = id;
    _name = name;
    _startDate = startDate;
    _endDate = endDate;
    _description = description;
    _state = state;
    _attendants = attendants;
    _image = image;
  }

  String get id => _id;

  String get name => _name;

  DateTime get startDate => _startDate;

  DateTime get endDate => _endDate;

  EventState get state => _state;

  String get description => _description;

  EventAttendantsOverview get attendants => _attendants;

  EventImage get image => _image;

  String when() {
    if (_startDate.day == _endDate.day &&
        _startDate.month == _endDate.month &&
        _startDate.year == _endDate.year) {
      var formatter = new DateFormat('MMM d, y jm');

      return formatter.format(_startDate);
    } else {
      var formatter = new DateFormat('MMM d, y');

      return "${formatter.format(_startDate)} - ${formatter.format(_endDate)}";
    }
  }
}
