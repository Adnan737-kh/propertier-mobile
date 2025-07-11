import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/constant.dart';
import '../../../constant/colors.dart';
import '../../../Utils/app_text.dart';
import '../../../Utils/appbar.dart';
import '../Model/Official_team_model.dart';
import '../ViewModel/offiacialteam_view_model.dart';
import 'component/officail_team_tile.dart';

class OfficialTeamView extends StatelessWidget {
  OfficialTeamView({super.key});
  final viewModel = Get.find<OfficialTeamViewModel>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: context.width * 0.060),
                child: Column(
                  children: [
                    getHeight(context, 0.050),
                    customAppBar(
                        context: context,
                        onTap: () => Get.back(),
                        title: "Official Team",
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                    getHeight(context, 0.050),
                  ],
                ),
              ),
              getHeight(context, 0.015),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: context.width * 0.050),
                child: Column(
                  children: [
                    //Invations
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      AppColor.darkGreyColor.withOpacity(0.25),
                                  blurRadius: 4,
                                  offset: const Offset(0, 0))
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            getHeight(context, 0.008),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Gap(15),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          title: "Khuram Mistri",
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        const Gap(5),
                                        CustomText(
                                          title: "Employee",
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        const Gap(5),
                                        CustomText(
                                            title: "Steel Worker",
                                            fontSize: 8,
                                            fontWeight: FontWeight.normal,
                                            colorOpecity: 0.7),
                                        const Gap(11),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      const Gap(15),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            AntDesign.close_circle_fill,
                                            color: AppColor.buttonColor,
                                          ),
                                          const Gap(18),
                                          Image.asset(
                                            Constant.completedIcon,
                                            color: AppColor.greenColor,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Gap(15)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    //Leaders
                    const Gap(16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            title: "Leader",
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                          const Icon(
                            Icons.add_circle,
                            color: AppColor.buttonColor,
                          )
                        ],
                      ),
                    ),
                    const Gap(8),

                    TeamOfficailTile(
                        team: TeamModel(
                            id: "213JKJH231J21",
                            salary: "90k",
                            name: "Sohail Basheer",
                            department: "Finance & Admin",
                            status: "Leader")),

                    TeamOfficailTile(
                        team: TeamModel(
                            id: "213JKJH231J21",
                            salary: "90k",
                            name: "Anees Shahad",
                            department: "Finance & Admin",
                            status: "Leader")),

                    //Employee

                    const Gap(16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            title: "Employee",
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                          const Icon(
                            Icons.add_circle,
                            color: AppColor.buttonColor,
                          )
                        ],
                      ),
                    ),
                    const Gap(8),

                    TeamOfficailTile(
                        team: TeamModel(
                            id: "213JKJH231J21",
                            salary: "90k",
                            name: "Sohail",
                            department: "Social Media Manager",
                            status: "Employee")),
                    TeamOfficailTile(
                        team: TeamModel(
                            id: "213JKJH231J21",
                            salary: "90k",
                            name: "Bilal",
                            department: "Social Media Manager",
                            status: "Employee")),
                    TeamOfficailTile(
                        team: TeamModel(
                            id: "213JKJH231J21",
                            salary: "90k",
                            name: "Sohrab",
                            department: "Social Media Manager",
                            status: "Employee")),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
