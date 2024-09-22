import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SelectFeatuedTypeController extends GetxController {
  var _selectedFeaturedType = "Normal".obs;

  RxString get selectedFeaturedType => _selectedFeaturedType;

  set selectedFeaturedType(value) {
    _selectedFeaturedType = value;
  }

  var _featuredItem = 'Property'.obs;

  RxString get featuredItem => _featuredItem;

  set featuredItem(value) {
    _featuredItem = value;
  }

  var featuredItemsList = ['Profile', 'Property'];

  List<String> featuredTypeList = ['Feature Ad', 'Blazing Ad', 'Banner Ad'];

  final RxString _pickedFrontImage = ''.obs;
  String get pickedImage => _pickedFrontImage.value;
  setPickedImage(String val) => _pickedFrontImage.value = val;

  Future<void> pickImage(t) async {
    final imageFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    if (imageFile != null) {
      _pickedFrontImage.value = imageFile.path;
    }
  }
}
