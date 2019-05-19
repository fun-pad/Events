class Reply {
  String _id;
  String _commentId;
  String _authorId;
  String _text;

  Reply(this._id, this._commentId, this._authorId, this._text);

  String get text => _text;

  String get authorId => _authorId;

  String get commentId => _commentId;

  String get id => _id;
}
