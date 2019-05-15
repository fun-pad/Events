import 'Attendant.dart';
import 'Comment.dart';
import 'EventImage.dart';
import 'EventState.dart';

class EventDetails {
  int _id;
  String _name;
  DateTime _startDate;
  DateTime _endDate;
  EventState _state;
  String _description;
  List<Attendant> _attendantsGoing;
  List<Comment> _comments;
  EventImage _image;

  EventDetails(
      this._id,
      this._name,
      this._startDate,
      this._endDate,
      this._state,
      this._description,
      this._attendantsGoing,
      this._comments,
      this._image);

  String get name => _name;

  DateTime get startDate => _startDate;

  DateTime get endDate => _endDate;

  EventState get state => _state;

  String get description => _description;

  EventImage get image => _image;

  int get id => _id;

  List<Attendant> get attendantsGoing => _attendantsGoing;

  List<Comment> get comments => _comments;
}
