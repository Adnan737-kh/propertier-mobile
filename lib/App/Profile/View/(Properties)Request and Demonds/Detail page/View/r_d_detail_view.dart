import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/divider.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
import '../../../../../../Utils/appbar.dart';
import '../../../../../../Utils/date_convert.dart';
import '../../../../../../Utils/textStyle.dart';
import '../../Model/request_model.dart';

class RDDetailView extends StatelessWidget {
  const RDDetailView({super.key, required this.property, required this.appBar});
  final Request property;
  final String appBar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              getHeight(context, 0.030),
              customAppBar(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  context: context,
                  onTap: () {
                    Get.back();
                  },
                  title: appBar),
              getHeight(context, 0.025),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColor.textColorGrey,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                            text: TextSpan(
                                style: textStyle(
                                    context: context,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    withOpacity: 0.7),
                                text: "ID: ",
                                children: [
                              TextSpan(
                                style: textStyle(
                                    fontSize: 10,
                                    context: context,
                                    fontWeight: FontWeight.w400,
                                    withOpacity: 0.6),
                                text: property.id!.toString(),
                              )
                            ])),
                        RichText(
                            text: TextSpan(
                          style: textStyle(
                              fontSize: 10,
                              context: context,
                              fontWeight: FontWeight.w400,
                              withOpacity: 0.6),
                          text: DateConvert().changeDate(property.createdAt!),
                        )),
                      ],
                    ),
                    const Gap(5),
                    divider(context: context, withOpacity: 0.6),
                    itemTIle(
                        context: context,
                        title: "City",
                        subTitle: property.city ?? ''),
                    itemTIle(
                        context: context,
                        title: "Price",
                        subTitle:
                            "${property.minPrice ?? ''}TO${property.maxPrice ?? ''}"),
                    itemTIle(
                        context: context,
                        title: "Area",
                        subTitle: property.area ?? ''),
                    itemTIle(
                        context: context,
                        title: "Property Type",
                        subTitle: property.type ?? ""),
                    const Gap(5),
                  ],
                ),
              ),
              getHeight(context, 0.025),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColor.textColorGrey,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                            text: TextSpan(
                                style: textStyle(
                                    context: context,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    withOpacity: 0.7),
                                text: "Additional Details",
                                children: [
                              TextSpan(
                                style: textStyle(
                                    fontSize: 8,
                                    context: context,
                                    fontWeight: FontWeight.w400,
                                    withOpacity: 0.6),
                                text: " (Optional)",
                              )
                            ])),
                      ],
                    ),
                    const Gap(5),
                    divider(context: context, withOpacity: 0.6),
                    itemTIle(
                        context: context,
                        title: "Name",
                        subTitle: property.name ?? ''),
                    itemTIle(
                        context: context,
                        title: "Phone Number",
                        subTitle: property.phoneNumber ?? ''),
                    itemTIle(
                        context: context,
                        title: "Email",
                        subTitle: property.email ?? ''),
                    itemTIle(
                        context: context,
                        title: "Description",
                        subTitle: property.description ?? ''),
                    const Gap(5),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Column itemTIle(
      {required BuildContext context,
      required String title,
      required String subTitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(15),
        appText(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            title: title,
            context: context,
            colorOpecity: 0.6),
        const Gap(5),
        appText(
            textAlign: TextAlign.start,
            fontSize: 12,
            title: subTitle,
            context: context,
            colorOpecity: 0.6),
        const Gap(5),
        divider(context: context, withOpacity: 0.6),
      ],
    );
  }
}
