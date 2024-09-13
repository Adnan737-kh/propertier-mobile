import 'package:propertier/App/ShortVideo/Model/short_video_model.dart';

class VideoDetailModel {
  final List<String> _imageUrlList;
  final String _description;
  final String _vendor;
  final String _type;
  final String _area;
  final ShortVideoModel _shortVideo;
  VideoDetailModel({
    required List<String> imageUrlList,
    required String description,
    required ShortVideoModel shortVideo,
    required String vendor,
    required String type,
    required String area,
  })  : _imageUrlList = imageUrlList,
        _description = description,
        _vendor = vendor,
        _shortVideo = shortVideo,
        _type = type,
        _area = area;

  List<String> get imageUrlList => _imageUrlList;
  ShortVideoModel get shortVideo => _shortVideo;
  String get description => _description;
  String get vendor => _vendor;
  String get type => _type;
  String get area => _area;
}
