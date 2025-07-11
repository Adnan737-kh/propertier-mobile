import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:propertier/App/Services/Model/FixedServicesModel.dart';
import 'package:http/http.dart' as http;
import 'package:propertier/App/Services/Model/services_model.dart';

import '../../../Network/api_urls.dart';
import '../../../Utils/app_text.dart';
import '../../../constant/colors.dart';
import '../Model/ServiceDashboardModel.dart';

class ServicesCore {
  Future<List<FixedServicesModel>> getFixedServices(
      {required BuildContext context}) async {
    List<FixedServicesModel> services = [];
    try {
      final response = await http.get(Uri.parse(API.fixedServices));
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        if (kDebugMode) {
          print("services status body !! ${response.body}");
        }

        for (var data in decodedJson) {
          services.add(FixedServicesModel.fromJson(data));
        }
        if (kDebugMode) {
          print("services status code !! ${response.statusCode}");
        }

        return services;
      } else {
        if (kDebugMode) {
          print("services status code !! ${response.statusCode}");
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: CustomText(
                title: 'Something went wrong Fixed Services.',
                color: AppColor.white)));
      }
    } catch (e) {
      if (kDebugMode) {
        print("error: $e");
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: CustomText(
              title: e.toString(), color: AppColor.white)));
    }

    return services;
  }

  Future<List<ParentServicesModel>> getAllParentServices(
      {required BuildContext context}) async {
    List<ParentServicesModel> services = [];
    try {
      final response = await http.get(Uri.parse(API.fetchParentServices));
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        if (kDebugMode) {
          print("home data response: $decodedJson");
        }
        for (var data in decodedJson) {
          services.add(ParentServicesModel.fromJson(data));
        }
        return services;
      } else {
        if (kDebugMode) {
          print("Parent Services StatusCode: ${response.statusCode}");
          print("Parent Services Body: ${response.body}");
        }

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: CustomText(
                title: 'Something went wrong getAllParentServices.',
                color: AppColor.white)));
      }
    } catch (e) {
      if (kDebugMode) {
        print("error: $e");
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: CustomText(
              title: e.toString(), color: AppColor.white)));
    }

    return services;
  }

  Future<ServiceDashboardModel?> servicesDashboard(
      {required BuildContext context}) async {
    ServiceDashboardModel? model;
    try {
      final response = await http.get(Uri.parse(API.serviceMobileDashboard));
      if (kDebugMode) {
        print('servicesDashboard status COde ${response.statusCode}');
      }
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        if (kDebugMode) {
          print('servicesDashboard body${response.body}');
        }

        model = ServiceDashboardModel.fromJson(decodedJson);
        return model;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: CustomText(
                title: 'Something went wrong servicesDashboard.',
                color: AppColor.white)));
      }
    } catch (e) {
      if (kDebugMode) {
        print("error is: $e");
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: CustomText(
              title: e.toString(),color: AppColor.white)));
    }
    return null;
  }

  Future<ServicePaginationModel?> servicesPagination(
      {required BuildContext context}) async {
    ServicePaginationModel? model;
    try {
      String url = "${API.servicesWithPagination}?page=1&limit=20";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        if (kDebugMode) {
          print('pagination data ${response.body}');
        }
        model = ServicePaginationModel.fromJson(decodedJson);
        return model;
      } else {
        if (kDebugMode) {
          print('servicesWithPagination body ${response.body}');
          print('servicesWithPagination status code ${response.statusCode}');

        }

        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     content: appText(
        //         title: 'Something went wrong servicesPagination.',
        //         context: context,
        //         color: AppColor.white)));
      }
    } catch (e) {
      if (kDebugMode) {
        print("servicesWithPagination catch block error: $e");
      }
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: appText(
      //         title: e.toString(), context: context, color: AppColor.white)));
    }
    return model;
  }
}
