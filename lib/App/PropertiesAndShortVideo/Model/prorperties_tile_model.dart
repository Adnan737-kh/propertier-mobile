class ArchitectureModel {
  final String _image;
  final bool _isFavorite;
  final String _title;
  final String _time;
  final String _price;
  final String _area;
  final String _location;
  ArchitectureModel({
    required String image,
    required bool isFavorite,
    required String price,
    required String area,
    required String location,
    required String time,
    required String title,
  })  : _image = image,
        _title = title,
        _area = area,
        _time = time,
        _price = price,
        _location = location,
        _isFavorite = isFavorite;

  bool get isFavorite => _isFavorite;
  String get time => _time;
  String get price => _price;
  String get location => _location;
  String get area => _area;
  String get title => _title;
  String get image => _image;
}
