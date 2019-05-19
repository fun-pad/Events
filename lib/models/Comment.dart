import 'Reply.dart';

class Comment {
  String _id;
  String _authorId;
  String _text;
  List<Reply> _reply;

  Comment(this._id, this._authorId, this._text, this._reply);

  List<Reply> get reply => _reply;

  String get text => _text;

  String get authorId => _authorId;

  String get id => _id;
}
