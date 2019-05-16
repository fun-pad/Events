class Attendant {
  String _imagePath;
  String _name;
  int _id;

  Attendant(this._imagePath, this._name, this._id);

  int get id => _id;

  String get name => _name;

  String get imagePath => _imagePath;
}
