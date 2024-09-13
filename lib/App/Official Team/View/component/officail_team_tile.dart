import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../constant/colors.dart';
import '../../../../constant/constant.dart';
import '../../../../Utils/app_text.dart';
import '../../../../Utils/height_width_box.dart';
import '../../Model/Official_team_model.dart';

class TeamOfficailTile extends StatelessWidget {
  const TeamOfficailTile({super.key, required this.team});
  final TeamModel team;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Container(
        decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: AppColor.darkGreyColor.withOpacity(0.25),
                  blurRadius: 4,
                  offset: const Offset(0, 0))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(2),
                      bottomRight: Radius.circular(2)),
                  boxShadow: [
                    BoxShadow(
                        color: AppColor.darkGreyColor.withOpacity(0.25),
                        blurRadius: 4,
                        offset: const Offset(0, 0))
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        appText(
                            title: "ID: ",
                            context: context,
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                            colorOpecity: 0.6),
                        appText(
                            title: team.id,
                            context: context,
                            fontSize: 8,
                            fontWeight: FontWeight.normal,
                            colorOpecity: 0.4)
                      ],
                    ),
                    Row(
                      children: [
                        appText(
                            title: "Salary ",
                            context: context,
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                            colorOpecity: 0.6),
                        appText(
                            title: team.salary,
                            context: context,
                            fontSize: 8,
                            fontWeight: FontWeight.normal,
                            colorOpecity: 0.4)
                      ],
                    )
                  ],
                ),
              ),
            ),
            getHeight(context, 0.008),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(Constant.dummayImage),
                  ),
                  const Gap(5),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        appText(
                          title: team.name,
                          context: context,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                        const Gap(5),
                        appText(
                          title: team.status,
                          context: context,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                        const Gap(5),
                        appText(
                            title: team.department,
                            context: context,
                            fontSize: 8,
                            fontWeight: FontWeight.normal,
                            colorOpecity: 0.7),
                        const Gap(11),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                border: Border.all(color: Colors.green[600]!)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 3),
                              child: appText(
                                  title: "Detail",
                                  context: context,
                                  fontSize: 10,
                                  color: Colors.green[600]!,
                                  fontWeight: FontWeight.normal,
                                  colorOpecity: 1),
                            )),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Gap(60),
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.green[600]!,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            child: appText(
                                title: "Remove",
                                context: context,
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                colorOpecity: 1),
                          )),
                      const Gap(11),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
