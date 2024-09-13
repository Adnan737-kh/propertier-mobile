import 'package:get/get.dart';

class RequestDemandViewModel extends GetxController {
  final _currentStep = 0.obs;

  int get getCountStep => _currentStep.value;

  final tabSelect = false.obs;
  // get tabSelect => _tabSelect.value;
  setTabSelect(value) => tabSelect.value = value;

  changeSelectedStepper(int index) {
    _currentStep.value = index;
  }
}
