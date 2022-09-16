class SellerModel {
  int _id;
  String _fName;
  String _lName;
  String _phone;
  String _image;
  Shop _shop;

  SellerModel(int id, String fName, String lName, String phone, String image,
      Shop shop) {
    this._id = id;
    this._fName = fName;
    this._lName = lName;
    this._phone = phone;
    this._image = image;
    this._shop = shop;
  }


  int get id => _id;
  String get fName => _fName;
  String get lName => _lName;
  String get phone => _phone;
  String get image => _image;
  // ignore: unnecessary_getters_setters
  Shop get shop => _shop;
  // ignore: unnecessary_getters_setters
  set shop(Shop value) {
    _shop = value;
  }

  SellerModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _fName = json['f_name'];
    _lName = json['l_name'];
    _phone = json['phone'];
    _image = json['image'];
    _shop = json['shop'] != null ? new Shop.fromJson(json['shop']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['f_name'] = this._fName;
    data['l_name'] = this._lName;
    data['phone'] = this._phone;
    data['image'] = this._image;
    if (this._shop != null) {
      data['shop'] = this._shop.toJson();
    }
    return data;
  }
}

class Shop {
  String get discription => _discription;

  bool get isVerified => _isVerified;
  int _id;
  String _name;
  String _address;
  String _contact;
  String _image;
  String _createdAt;
  String _updatedAt;
  double _rate;
  String _discription;
  bool _isVerified;
  int _likes;
  String _facebook;

  String get phone => _phone;
  String _tiktok;
  String _whatsapp;
  String _phone;
  String _instagram;
  String _twitter;
  Shop(
      {int id,
      String name,
      String address,
      String contact,
      String image,
      String createdAt,
      String updatedAt}) {
    this._id = id;
    this._name = name;
    this._address = address;
    this._contact = contact;
    this._image = image;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  int get id => _id;
  String get name => _name;
  String get address => _address;
  String get contact => _contact;
  String get image => _image;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  Shop.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _address = json['address'];
    _contact = json['contact'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _isVerified = json['IsVerified'] == 1;
    _discription = json['Bio'];
    _rate = json['Rating'];
    _tiktok = json['tiktok'];
    _facebook = json['facebook'];
    _whatsapp = json['whatsapp'];
    _instagram = json['instagram'];
    _twitter = json['twitter'];
    _likes = json['likes']??0;
    _phone = json['phone'];
  }

  int get likes => _likes;

  double get rate => _rate;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['address'] = this._address;
    data['contact'] = this._contact;
    data['image'] = this._image;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }

  String get facebook => _facebook;

  String get tiktok => _tiktok;

  String get whatsapp => _whatsapp;

  String get instagram => _instagram;

  String get twitter => _twitter;
}
