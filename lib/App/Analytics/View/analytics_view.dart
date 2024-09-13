import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Analytics/Model/chart_subtitle_model.dart';
import 'package:propertier/App/Analytics/View/components/chart_tile.dart';
import 'package:propertier/App/Analytics/ViewModel/analytics_view_model.dart';
import 'package:propertier/Utils/appbar.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/size_extension.dart';

enum ChartsType { line, combination, spline, lineArea }

class AnalyticsView extends StatelessWidget {
  AnalyticsView({super.key});
  final viewModel = Get.find<AnalyticsViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: context.getSize.width * 0.060),
        child: Column(
          children: [
            customAppBar(
                context: context,
                onTap: () {
                  Get.back();
                },
                title: 'Analytics'),
            getHeight(context, 0.030),
            Expanded(
                child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Obx(
                  () => chartTile(
                      spline1Data: [],
                      spline2Data: [],
                      lineChartData: viewModel.isThisWeekLineData == "This Week"
                          ? viewModel.lineChartData
                          : viewModel.lineChartDataNext,
                      columnChartData: [],
                      dropDownValue: viewModel.isThisWeekLineData,
                      context, dropDownCallBack: (val) {
                    viewModel.changeLineWeek(val);
                    print(val);
                  },
                      dropDownList: [
                        'This Week',
                        'Next Week',
                      ],
                      title: 'Sale Overview',
                      chartType: ChartsType.line,
                      subtitleList: viewModel.chartSubtitleList,
                      viewDetailsCallBack: () {}),
                ),
                getHeight(context, 0.015),
                Obx(
                  () => chartTile(
                    spline1Data: [],
                    spline2Data: [],
                    lineChartData: [],
                    columnChartData:
                        viewModel.isThisWeekColumnData == "This Week"
                            ? viewModel.columnDataThisWeek
                            : viewModel.columnDataNextWeek,
                    context,
                    title: 'Ads Overview',
                    subtitleList: [
                      ChartSubtitleModel(
                          subtitle: 'Ads', color: AppColor.lightBlueColor),
                      ChartSubtitleModel(
                          subtitle: 'Costs', color: AppColor.buttonColor)
                    ],
                    dropDownList: ['This Week', 'Next Week'],
                    chartType: ChartsType.combination,
                    dropDownCallBack: (val) {
                      viewModel.changeColumnWeek(val);
                    },
                    viewDetailsCallBack: () {},
                    dropDownValue: viewModel.isThisWeekColumnData,
                  ),
                ),
                getHeight(context, 0.015),
                Obx(
                  () => chartTile(
                      spline1Data: viewModel.isThisWeekSplineData == 'This Week'
                          ? viewModel.spline1ThisWeek
                          : viewModel.spline1NextWeek,
                      spline2Data: viewModel.isThisWeekSplineData == 'This Week'
                          ? viewModel.splin2ThisWeek
                          : viewModel.splin2NextWeek,
                      lineChartData: [],
                      columnChartData: [],
                      dropDownValue: viewModel.isThisWeekSplineData,
                      context, dropDownCallBack: (val) {
                    viewModel.changeSplineWeek(val);
                  },
                      dropDownList: [
                        'This Week',
                        'Next Week',
                      ],
                      title: 'Followers Overview',
                      chartType: ChartsType.spline,
                      subtitleList: [
                        ChartSubtitleModel(
                            subtitle: 'Followers Gain',
                            color: AppColor.lightBlueColor),
                        ChartSubtitleModel(
                            subtitle: 'Followers Lost',
                            color: AppColor.buttonColor),
                      ],
                      viewDetailsCallBack: () {}),
                ),
                getHeight(context, 0.015),
                Obx(
                  () => chartTile(
                      spline1Data: [],
                      spline2Data: [],
                      lineChartData: viewModel.isThisWeekLineData == "This Week"
                          ? viewModel.lineAreaChartData
                          : viewModel.lineAreaChartData,
                      columnChartData: [],
                      dropDownValue: viewModel.isThisWeekLineData,
                      context, dropDownCallBack: (val) {
                    viewModel.changeLineWeek(val);
                    print(val);
                  },
                      dropDownList: [
                        'This Week',
                        'Next Week',
                      ],
                      title: 'Sale Overview',
                      chartType: ChartsType.lineArea,
                      subtitleList: viewModel.chartSubtitleList,
                      viewDetailsCallBack: () {}),
                ),
              ],
            ))
          ],
        ),
      )),
    );
  }
}
