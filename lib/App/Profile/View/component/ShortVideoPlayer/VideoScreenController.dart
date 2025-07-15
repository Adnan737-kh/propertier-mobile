import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Like%20And%20Unlike%20Service/Model/isLiked.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

import '../../../../../Model/property.dart';
import '../../../../Home/ViewModel/home_view_model.dart';
import '../../../../Like And Unlike Service/like_unlike_services.dart';

class VideoScreenController extends GetxController {
   List<Property> properties;
  final Property property;
  VideoScreenController(this.properties, this.property);


  final List<VideoPlayerController> videoControllers = <VideoPlayerController>[].obs;
  RxInt activeVideoIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    if(properties.isEmpty){
      properties = Get.find<HomeViewModel>().homeModel.value.data!.shortVideos;
    }
    properties = shiftPropertyToFirst(properties, property);
    if (kDebugMode) {
      print("*****properties:");
    }
    for(Property p in properties){
      if (kDebugMode) {
        print(p.id.toString());
      }
    }
    _initializeControllers();
    getSpecificPropertyDetail(activeVideoIndex.value);
  }



   List<Property> shiftPropertyToFirst(List<Property> propertyList, Property targetProperty) {
     // Check if the list contains the target property
     if (!propertyList.contains(targetProperty)) {
       return List.from(propertyList); // Return the original list if property not found
     }

     // Create a new list from the original list
     List<Property> newList = List.from(propertyList);

     if (kDebugMode) {
       print("List before shift");
     }
     for(Property p in newList){
       if (kDebugMode) {
         print(p.id.toString());
       }
     }
     // Remove the target property
     newList.remove(targetProperty);

     if (kDebugMode) {
       print("List after remove");
     }
     for(Property p in newList){
       if (kDebugMode) {
         print(p.id.toString());
       }
     }
     // Insert the target property at the first index
     newList.insert(0, targetProperty);

     if (kDebugMode) {
       print("List after insert");
     }
     for(Property p in newList){
       if (kDebugMode) {
         print(p.id.toString());
       }
     }
     return newList;
   }


  Future<void> _initializeControllers() async {
    for (var i = 0; i < properties.length; i++) {
      if (i < 5) {
        await _createControllerForIndex(i);
      }
    }
  }

  Future<void> _createControllerForIndex(int index) async {
    if (index < properties.length && properties[index].shortVideo != null && properties[index].shortVideo != "") {
      final controller = VideoPlayerController.networkUrl(Uri.parse(properties[index].shortVideo!));
      await controller.initialize();
      controller.setLooping(true); // Loop video for continuous playback
      videoControllers.add(controller);
      if (index == 0) {
        controller.play(); // Play the first video initially
      }
    }
  }

  void pauseOrPlayVideo(int index) {
    if (videoControllers[index].value.isPlaying) {
      videoControllers[index].pause();
    } else {
      videoControllers[index].play();
    }
  }
  void pauseOrPlayVideoC(VideoPlayerController videoPlayerController) {
    if (videoPlayerController.value.isPlaying) {
      videoPlayerController.pause();
    } else {
      videoPlayerController.play();
    }
  }

  void onVideoChanged(int newIndex) async {
    if (newIndex != activeVideoIndex.value) {
      // Pause the previous video
      videoControllers[activeVideoIndex.value].pause();
      getSpecificPropertyDetail(newIndex);
      // Play the new video
      activeVideoIndex.value = newIndex;
      videoControllers[newIndex].play();

      // Preload the next 5 videos
      for (var i = newIndex; i < newIndex + 5 && i < properties.length; i++) {
        if (i >= videoControllers.length) {
          await _createControllerForIndex(i);
        }
      }
    }
  }

  Rx<IsLiked> isLiked = IsLiked().obs;
   getSpecificPropertyDetail(int newIndex) async {
     isLiked.value = await LikeAndUnlikeServices().getProperty(
         agentId: properties[newIndex].agent!.id.toString(),
         propertyId: properties[newIndex].id!.toString());
     if (kDebugMode) {
       print("Here is like data ${isLiked.toJson()}");
     }

   }


   void shareReel()async{
     await Share.share('check out this Propertier App: https://play.google.com/store/apps/details?id=com.propertier.propertiercom', subject: 'Look what I found! Propertier App');
   }

  @override
  void onClose(){
    // Dispose all video controllers
    for (var controller in videoControllers) {
      controller.dispose();
      if (kDebugMode) {
        print("closed");
      }
    }
    super.onClose();
  }


}