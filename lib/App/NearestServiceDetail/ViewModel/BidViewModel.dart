import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../Network/api_urls.dart';
import '../../../Utils/app_text.dart';
import '../../../constant/colors.dart';
import '../../ServicesSearch/Service/ServicesSearch_Service.dart';
import '../../ServicesSearch/model/VendorResponseModel.dart';

class BidViewModel extends GetxController{

  @override
  void onInit() {
    super.onInit();
    id = Get.arguments['id'];
    serviceId = Get.arguments['serviceId'];
    subServiceId = Get.arguments['subServiceId'];
    connectToWebSocket();

  }
  late String id;
  late String serviceId;
  late String subServiceId;
  late WebSocketChannel channel;

  RxList<VendorOfferModel> offers = <VendorOfferModel>[].obs;

  void connectToWebSocket() {
    try {
      String url = "${API.listenBidByVendor}$id/";
      if (kDebugMode) {
        print(url);
      }
      channel = WebSocketChannel.connect(
        Uri.parse(url),
      );

      channel.stream.listen(
            (data) {
          final jsonData = jsonDecode(data);
          VendorOfferModel vendorOfferModel = VendorOfferModel.fromJson(jsonData);
          print(vendorOfferModel.bidResponse?.amount);
          if(vendorOfferModel.bidResponse?.id != null){
            offers.clear();
            offers.add(vendorOfferModel);
          }
        },
        onError: (error) {
          print('WebSocket Error: $error');
        },
        onDone: () {
          print('WebSocket connection closed.');
        },
      );
    } catch (e) {
      print('Error connecting to WebSocket: $e');
    }
  }


  Future acceptBid(BuildContext context, String id, String status)async{
    ServicessearchService().acceptBid(context, id, status);
  }

  Future finalizeBid(BuildContext context, String id, String status,String vendorId)async{
    ServicessearchService().finalizeBid(context, id, status, vendorId);
  }

  Future<bool> createOrder({required BuildContext context,required String bidId,required String vendorId,required String customerId,required String serviceLocation,required String status, required String paymentStatus})async{
    bool res = await ServicessearchService().createOrder(context: context, bidId: bidId, vendorId: vendorId, customerId: customerId, serviceId: serviceId??"", subServiceId: subServiceId??"", serviceLocation: serviceLocation, status: status, paymentStatus: paymentStatus);
    if(res){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: appText(
              title: "Order Created Successfully",
              context: context,
              color: AppColor.white)));
    }
    return res;
  }
}