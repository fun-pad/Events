import 'Reply.dart';

class Comment {
  int _id;
  int _authorId;
  String _text;
  List<Reply> _reply;

  Comment(this._id, this._authorId, this._text, this._reply);

  List<Reply> get reply => _reply;

  String get text => _text;

  int get authorId => _authorId;

  int get id => _id;
}
