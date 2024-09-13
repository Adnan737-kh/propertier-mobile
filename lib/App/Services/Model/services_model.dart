class ServicesModel {
  final String _title;
  final String? _icon;
  ServicesModel({
    required String title,
    String? icon,
  })  : _icon = icon,
        _title = title;
  String get title => _title;
  String get icon => _icon!;
}
