import 'package:flutter/material.dart';
import 'package:propertier/App/Analytics/Model/chart_subtitle_model.dart';
import 'package:propertier/App/Analytics/View/analytics_view.dart';
import 'package:propertier/App/Analytics/View/components/chart_tile.dart';
import 'package:propertier/App/Profile/ViewModel/profile_view_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';

Widget adsChart(BuildContext context, ProfileViewModel viewModel) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      appText(
        title: 'Ads',
        context: context,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      getHeight(context, 0.008),
      chartTile(context,
          title: 'Ads Overview',
          dropDownValue: '1 Week',
          subtitleList: [
            ChartSubtitleModel(
              subtitle: 'Team',
              color: AppColor.buttonColor,
            ),
            ChartSubtitleModel(
              subtitle: 'Sales',
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
          spline2Data: viewModel.splin2ThisWeek)
    ],
  );
}
