class Auth{

  int _id;
  String _token;

  Auth(this._token);

  Auth.map(dynamic obj) {
    this._id = obj['id'];
    this._token = obj['token'];
  }

  int get id => _id;
  String get token => _token;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['token'] = _token;

    return map;
  }

  Auth.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._token = map['token'];
  }
}