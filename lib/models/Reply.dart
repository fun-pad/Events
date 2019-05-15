class Reply {
  int _id;
  int _authorId;
  String _text;

  Reply(this._id, this._authorId, this._text);

  String get text => _text;

  int get authorId => _authorId;

  int get id => _id;
}
