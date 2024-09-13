import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MyOrderViewModel extends GetxController {
  List<String> carosualList = <String>[
    'https://plus.unsplash.com/premium_photo-1676637000058-96549206fe71?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
    'https://images.unsplash.com/photo-1488372759477-a7f4aa078cb6?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
    'https://images.unsplash.com/photo-1566438480900-0609be27a4be?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
  ];
  List<String> buttonTitle = <String>['Sell For Me', 'Rent For Me'];
  List<String> tabList = <String>['All', 'Complete', 'Rejected', "Pending"];
  TextEditingController searchController = TextEditingController();
  PageController pageController = PageController(initialPage: 0);

  final RxInt _selectedCrouselIndex = 0.obs;
  int get selectedCarouseIndex => _selectedCrouselIndex.value;
  changedCarouseValue(int indx) {
    _selectedCrouselIndex.value = indx;
  }

  final RxInt _selectedTabIndex = 0.obs;
  int get seletcedTabIndex => _selectedTabIndex.value;
  changeTabIndex(int index) {
    print("index is $index");
    _selectedTabIndex.value = index;
    pageController.jumpToPage(
      index,
    );
  }

  final RxBool _isViewMore = false.obs;
  bool get isViewMore => _isViewMore.value;
  viewMore(bool isMore) {
    _isViewMore.value = isMore;
  }
}
