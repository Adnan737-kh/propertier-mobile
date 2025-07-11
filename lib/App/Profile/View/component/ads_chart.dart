import 'package:flutter/material.dart';
import 'package:propertier/App/Analytics/Model/chart_subtitle_model.dart';
import 'package:propertier/App/Analytics/View/analytics_view.dart';
import 'package:propertier/App/Analytics/View/components/chart_tile.dart';
import 'package:propertier/App/Profile/ViewModel/profile_view_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/localization_extension.dart';

Widget adsChart(BuildContext context, ProfileViewModel viewModel) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomText(
        title: context.local.ads,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      getHeight(context, 0.008),
      chartTile(context,
          title: context.local.ads_overview,
          dropDownValue: '1 Week',
          subtitleList: [
            ChartSubtitleModel(
              subtitle: context.local.team,
              color: AppColor.buttonColor,
            ),
            ChartSubtitleModel(
              subtitle: context.local.sales,
              color: AppColor.lightBlueColor,
            ),
          ],
          dropDownList: ['1 Week', '2 Week'],
          chartType: ChartsType.spline,
          dropDownCallBack: (val) {},
          viewDetailsCallBack: () {},
          lineChartData: [],
          columnChartData: [],
          spline1Data: viewModel.spline1ThisWeek,
          spline2Data: viewModel.spline2ThisWeek)
    ],
  );
}
