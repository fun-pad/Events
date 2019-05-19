class User {
  String _imagePath;
  String _name;
  String _id;

  User(this._imagePath, this._name, this._id);

  String get id => _id;

  String get name => _name;

  String get imagePath => _imagePath;
}
