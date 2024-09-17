import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:propertier/App/Home/Model/comment_button_model.dart';
import 'package:propertier/App/Home/Model/home_model.dart';
import 'package:propertier/App/Home/Model/properties_tiler_button_model.dart';
import 'package:propertier/App/Home/Services/home_services.dart';
import 'package:propertier/constant/call_launcher.dart';
import 'package:propertier/constant/colors.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../../Model/property.dart';
import '../../../constant/constant.dart';
import '../Model/grid_tile_model.dart';

class HomeViewModel extends GetxController {
  List<String> carosualList = <String>[
    'https://plus.unsplash.com/premium_photo-1676637000058-96549206fe71?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
    'https://images.unsplash.com/photo-1488372759477-a7f4aa078cb6?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
    'https://images.unsplash.com/photo-1566438480900-0609be27a4be?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
  ];

  RxBool isSale = true.obs;
  Future changeSale(int val, BuildContext context) async {
    if (val == 0) {
      isSale.value = true;
    } else {
      isSale.value = false;
    }
  }

  List<String> buttonTitle = <String>['Sell For Me', 'Rent For Me'];
  List<String> tabList = <String>[
    'Commerical',
    'Residential',
    // 'Services',
  ];
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
    debugPrint("index is $index");
    _selectedTabIndex.value = index;
  }

  final RxBool _isViewMore = false.obs;
  bool get isViewMore => _isViewMore.value;
  viewMore(bool isMore) {
    _isViewMore.value = isMore;
  }

  RxList<PropertiesTileButtonModel> propertiesTileButtonList =
      <PropertiesTileButtonModel>[
    PropertiesTileButtonModel(
        onTap: (val) {
          if (val != '') {
            launchCallandSMS(type: 'sms', phoneNumber: val!);
          }
        },
        title: "SMS",
        color: AppColor.white,
        icon: null,
        titleColor: AppColor.greenColor,
        borderColor: AppColor.greenColor),
    PropertiesTileButtonModel(
        onTap: (val) async {
          if (val != '') {
            launchCallandSMS(type: 'tel', phoneNumber: val!);
          }
        },
        titleColor: AppColor.white,
        borderColor: AppColor.greenColor,
        title: 'Call',
        color: AppColor.greenColor,
        icon: Ionicons.call),
    PropertiesTileButtonModel(
        onTap: (val) async {
          if (val != '') {
            launchCallandSMS(type: 'tel', phoneNumber: val!);
          }
        },
        titleColor: AppColor.backgroundColor,
        borderColor: AppColor.forgroundColor,
        title: 'Chat',
        color: AppColor.forgroundColor,
        icon: null),
  ].obs;

  RxList<CommentButtonModel> commentButtonsList = <CommentButtonModel>[
    CommentButtonModel(icon: Ionicons.chatbubble_outline, title: '1'),
    CommentButtonModel(icon: Ionicons.return_up_back_outline, title: '4'),
    CommentButtonModel(icon: Ionicons.heart_outline, title: '2'),
    CommentButtonModel(icon: Ionicons.stats_chart_outline, title: '4'),
    CommentButtonModel(icon: Ionicons.share_social_outline, title: '')
  ].obs;
  final RxBool _isShowMoreComment = false.obs;
  bool get isShowMoreComment => _isShowMoreComment.value;
  showMoreComment(bool value) {
    _isShowMoreComment.value = value;
  }

  final RxList<String> _thumbnailList = <String>[].obs;
  List get thumbnailList => _thumbnailList;
  Future<List<String>> getThumbnailList(
      {required String video1, required String video2}) async {
    if (_thumbnailList.length < 2) {
      _thumbnailList.clear();
      print("Thumbnail Length ${_thumbnailList.length}");
      final video1Id = extractVideoIdFromUrl(video1);
      final video2Id = extractVideoIdFromUrl(video2);
      final yt = YoutubeExplode();
      final video1Data = await yt.videos.get(video1Id);
      final video2Data = await yt.videos.get(video2Id);
      yt.close();

      _thumbnailList.add(video1Data.thumbnails.mediumResUrl);
      _thumbnailList.add(video2Data.thumbnails.mediumResUrl);
    }
    return _thumbnailList;
  }

  Future<String> getThumbnail({
    required String video,
  }) async {
    final videoId = extractVideoIdFromUrl(video);
    final yt = YoutubeExplode();
    final videoData = await yt.videos.get(videoId);

    yt.close();

    return videoData.thumbnails.mediumResUrl;
  }

  String extractVideoIdFromUrl(String url) {
    print("MY URL is $url");
    RegExp regExp = RegExp(
        r'^.*(?:youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*');
    Match? match = regExp.firstMatch(url);
    if (match != null && match.groupCount >= 1) {
      return match.group(1)!;
    } else {
      // Invalid YouTube URL
      throw Exception('Invalid YouTube URL');
    }
  }

  RxBool isHomeDataAvailable = false.obs;

  Rx<HomeModel> homeModel = HomeModel().obs;
  Future<HomeModel> getHomePageData({required BuildContext context}) async {
    final result = await HomeServices().getHomeData(context: context);
    if (result.data != null) {
      homeModel.value = result;
      isHomeDataAvailable.value = true;
      // getShortVideos(context: context);
      // print("print posts Length ${homeModel.value.data!.posts!.length}");
    }
    return homeModel.value;
  }

  List<GridTileModel> comercialTileList = [
    GridTileModel(title: "Guest House", IconLink: Constant.guestHouseIcon),
    GridTileModel(title: "Food Court", IconLink: Constant.foodCourtIcon),
    GridTileModel(title: "Building", IconLink: Constant.buildingicon),
    GridTileModel(title: "Warehouse", IconLink: Constant.warehouseIcon),
    GridTileModel(title: "Hall", IconLink: Constant.hallIcon),
    GridTileModel(title: "Factory", IconLink: Constant.fairyHallicon),
    GridTileModel(title: "Theatre", IconLink: Constant.theaterIcon),
    GridTileModel(title: "Gym", IconLink: Constant.gymIcon),
    GridTileModel(title: "Marriage Hall", IconLink: Constant.marriageHallIcon),
    GridTileModel(title: "Marquee", IconLink: Constant.marqueeIcon),
    GridTileModel(title: "Flats", IconLink: Constant.flaticon),
    GridTileModel(title: "Plots", IconLink: Constant.plotsIcon),
    GridTileModel(title: "Plaza", IconLink: Constant.plazaIcon),
    GridTileModel(title: "Rooms", IconLink: Constant.roomIcon),
  ];

  List<GridTileModel> residentialList = [
    GridTileModel(title: "Villa", IconLink: Constant.villaIcon),
    GridTileModel(title: "House", IconLink: Constant.homeIcon),
    GridTileModel(title: "Flats", IconLink: Constant.flaticon),
    GridTileModel(title: "Plots", IconLink: Constant.plotsIcon),
    GridTileModel(title: "Plaza", IconLink: Constant.plazaIcon),
    GridTileModel(title: "Rooms", IconLink: Constant.roomIcon),
  ];
  // List<GridTileModel> listOfTiles = [
  //   GridTileModel(title: "Offices", IconLink: Constant.officeIcon),
  //   GridTileModel(title: "Shops", IconLink: Constant.shopIcon),
  //   GridTileModel(title: "Flats", IconLink: Constant.flaticon),
  //   GridTileModel(title: "Plots", IconLink: Constant.plotsIcon),
  //   GridTileModel(title: "Guest House", IconLink: Constant.guestHouseIcon),
  //   GridTileModel(title: "House", IconLink: Constant.homeIcon),
  //   GridTileModel(title: "Villa", IconLink: Constant.villaIcon),
  //   GridTileModel(title: "Plaza", IconLink: Constant.plazaIcon),
  //   GridTileModel(title: "Food Court", IconLink: Constant.foodCourtIcon),
  //   GridTileModel(title: "Building", IconLink: Constant.buildingicon),
  //   GridTileModel(title: "Warehouse", IconLink: Constant.warehouseIcon),
  //   GridTileModel(title: "Hall", IconLink: Constant.hallIcon),
  //   GridTileModel(title: "Factory", IconLink: Constant.fairyHallicon),
  //   GridTileModel(title: "Theatre", IconLink: Constant.theaterIcon),
  //   GridTileModel(title: "Gym", IconLink: Constant.gymIcon),
  //   GridTileModel(title: "Marriage Hall", IconLink: Constant.marriageHallIcon),
  //   GridTileModel(title: "Marquee", IconLink: Constant.marqueeIcon),
  //   GridTileModel(title: "Rooms", IconLink: Constant.roomIcon),
  // ];

  RxList<Property> shortVideoList = <Property>[].obs;
  Future<List<Property>> getShortVideos({required BuildContext context}) async {
    final result = await HomeServices().getShortVideoData(context: context);
    if (result.isNotEmpty || result.isNotEmpty) {
      shortVideoList.value = result;
    }
    return shortVideoList;
  }
}
