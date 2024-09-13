class ShortVideoModel {
  final String _videoUrl;
  final String _title;
  final String _subtitle;
  final String _avatarUrl;
  ShortVideoModel(
      {required String videoUrl,
      required String title,
      required String subtitle,
      required String avatarUrl})
      : _avatarUrl = avatarUrl,
        _videoUrl = videoUrl,
        _title = title,
        _subtitle = subtitle;
  String get avatarUrl => _avatarUrl;
  String get videoUrl => _videoUrl;
  String get subtitle => _subtitle;
  String get title => _title;
}
