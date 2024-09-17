import 'package:get/get.dart';

class VideoDetailViewModel extends GetxController {
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  final RxList<String> _videosThumbnailList = <String>[].obs;
  List<String> get videosThumbnailList => _videosThumbnailList.value;

  final RxInt _selectedVideoIndex = 0.obs;
  int get selectedVideoIndex => _selectedVideoIndex.value;
  changeVideoIndex(int index) {
    _selectedVideoIndex.value = index;
  }
}
