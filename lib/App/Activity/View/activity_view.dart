import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Activity/ViewModel/activity_viewmodel.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../RoutesAndBindings/app_routes.dart';
import '../../../Utils/appbar.dart';
import '../../../Utils/height_width_box.dart';
import '../Components/activity_tile.dart';

class ActivityView extends GetView<ActivityViewModel> {
  const ActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        padding: const EdgeInsets.only(
          left: 0,
          right: 0,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: context.getSize.width * 0.060),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                getHeight(context, 0.065),
                customAppBar(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    context: context,
                    onTap: () {
                      Get.back();
                    },
                    title: 'Activity'),
                getHeight(context, 0.045),
                activityTile(
                  title: "Post You Searched For",
                  onTap: () => Get.toNamed(AppRoutes.searchedActivityView),
                ),
                getHeight(context, 0.010),
                activityTile(
                  title: "Videos You have watched",
                ),
                getHeight(context, 0.010),
                activityTile(
                  title: "Comments",
                ),
                getHeight(context, 0.010),
                activityTile(
                  title: "People You Followed",
                ),
                getHeight(context, 0.010),
                activityTile(
                  title: "Your Post",
                ),
                getHeight(context, 0.06),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
