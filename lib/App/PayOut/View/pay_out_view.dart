import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Analytics/Model/chart_subtitle_model.dart';
import 'package:propertier/App/PayOut/View/component/income_expense_tile.dart';
import 'package:propertier/App/PayOut/View/component/multi_column_chart.dart';
import 'package:propertier/App/PayOut/ViewModel/pay_out_view_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/appbar.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/withdrawal_amount_tile.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

class PayOutView extends StatelessWidget {
  PayOutView({super.key});
  final viewModel = Get.find<PayOutViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: context.getSize.width * 0.060),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getHeight(context, 0.04),
              customAppBar(
                  context: context,
                  onTap: () {
                    Get.back();
                  },
                  title: context.local.payout),
              getHeight(context, 0.045),
              CustomText(
                title: context.local.total_balance,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                colorOpecity: 0.7,
              ),
              const CustomText(
                title: '20,000',
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              getHeight(context, 0.015),
              multiColumnChartTile(context,
                  title: context.local.overview,
                  dropDownValue: "This month",
                  subtitleList: [
                    ChartSubtitleModel(
                        subtitle: context.local.income,
                        color: AppColor.blackColor),
                    ChartSubtitleModel(
                        subtitle: context.local.expense,
                        color: AppColor.lightBlueColor)
                  ],
                  dropDownList: ["This month", "Last month"],
                  dropDownCallBack: (val) {},
                  viewDetailsCallBack: () {},
                  income: viewModel.thisMonthIncom,
                  expense: viewModel.thisMonthExpense),
              getHeight(
                context,
                0.015,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  incomExpenseTile(context, ammount: '20,000'),
                  incomExpenseTile(context, ammount: '20,000', isIncome: false),
                ],
              ),
              getHeight(context, 0.015),
              CustomText(
                  title: context.local.width_draw,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  colorOpecity: 0.7),
              getHeight(context, 0.005),
              Column(
                children: List.generate(
                    2,
                    (index) => withdrawalTile(context,
                        bankName: 'Bank Alfalah',
                        date: '10 feb 2023',
                        ammount: "10K",
                        bankIcon: Constant.alfalah)),
              )
            ],
          ),
        ),
      )),
    );
  }
}
