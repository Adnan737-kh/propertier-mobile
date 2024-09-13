import 'package:get/get.dart';

class SearchedActivityViewModel extends GetxController {
  final _currentStep = 0.obs;

  int get getCountStep => _currentStep.value;

  changeSelectedStepper(int index) {
    _currentStep.value = index;
  }
}
