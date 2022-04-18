class AddressModel {
  late int? _id;
  late String _addressType;
  late String? _contactPersonName;
  late String? _contactPersonNumber;
  late String _address;
  late String _latitude;
  late String _longitude;

  AddressModel(
      {id,
      required addressType,
      contactPersonName,
      contactPersonNumber,
      address,
      latitude,
      longitude}) {
    _id = id;
    _addressType = addressType;
    _contactPersonName = contactPersonName;
    _contactPersonNumber = contactPersonNumber;
    _address = address;
    _latitude = latitude;
    _longitude = longitude;
  }

  String get address => _address;
  String get addressType => _addressType;
  String? get contactPersonName => _contactPersonName;
  String? get contactPersonNumber => _contactPersonNumber;
  String? get longitude => _longitude;
  String? get latitude => _latitude;

  AddressModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _addressType = json['address'];
    _contactPersonName = json['contact_person_name'] ?? '';
    _contactPersonNumber = json['contact_person_number'] ?? '';
    _address = json['address'] ?? "";
    _latitude = json['latitude'];
    _longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'address_type': _addressType,
      'contact_person_name': _contactPersonName,
      'contact_person_number': contactPersonNumber,
      'address': _address,
      'latitude': latitude,
      'longitude': _longitude
    };
  }
}
