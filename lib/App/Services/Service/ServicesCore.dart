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
            content: appText(
                title: 'Something went wrong Fixed Services.',
                context: context,
                color: AppColor.white)));
      }
    } catch (e) {
      if (kDebugMode) {
        print("error: $e");
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: appText(
              title: e.toString(), context: context, color: AppColor.white)));
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: appText(
                title: 'Something went wrong getAllParentServices.',
                context: context,
                color: AppColor.white)));
      }
    } catch (e) {
      if (kDebugMode) {
        print("error: $e");
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: appText(
              title: e.toString(), context: context, color: AppColor.white)));
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
        model = ServiceDashboardModel.fromJson(decodedJson);
        return model;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: appText(
                title: 'Something went wrong servicesDashboard.',
                context: context,
                color: AppColor.white)));
      }
    } catch (e) {
      if (kDebugMode) {
        print("error: $e");
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: appText(
              title: e.toString(), context: context, color: AppColor.white)));
    }
  }

  Future<ServicePaginationModel?> servicesPagination(
      {required BuildContext context}) async {
    ServicePaginationModel? model;
    try {
      String url = "${API.servicesWithPagination}?limit=20";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        model = ServicePaginationModel.fromJson(decodedJson);
        return model;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: appText(
                title: 'Something went wrong servicesPagination.',
                context: context,
                color: AppColor.white)));
      }
    } catch (e) {
      if (kDebugMode) {
        print("error: $e");
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: appText(
              title: e.toString(), context: context, color: AppColor.white)));
    }
    return model;
  }
}
