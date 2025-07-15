import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:propertier/App/SearchEngine/ViewModel/searh_engine_view_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/search_text_field.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

class SearchEngineView extends StatelessWidget {
  SearchEngineView({super.key});
  final viewModel = Get.find<SearchEngineViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: context.getSize.width * 0.090),
        child: Column(
          children: [
            getHeight(context, 0.040),
            SearchTextField(
                onChange: (vl) {
                  viewModel.searchData(vl);
                  if (vl.isEmpty) {
                    viewModel.searchedList.clear();
                  }
                },
                horizontalPadding: 0,
                searchController: viewModel.searchController,
                suFixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        Constant.mic,
                      ),
                    ),
                    getWidth(context, 0.01),
                    Container(
                      height: context.getSize.height * 0.02,
                      width: 1,
                      color: AppColor.primaryColor,
                    ),
                    getWidth(context, 0.01),
                    const CustomText(
                        title: 'nearby',
                        fontSize: 10,
                        color: AppColor.primaryColor,
                        colorOpecity: 0.6),
                    getWidth(context, 0.01),
                    Icon(
                      Ionicons.location,
                      color: const Color(0xffF24E1E),
                      size: context.getSize.height * 0.018,
                    )
                  ],
                )),
            Obx(
              () => viewModel.searchedList.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Text(context.local.no_data_search_yet),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: viewModel.searchedList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                textAlign: TextAlign.start,
                                title: viewModel.searchedList[index],
                              ),
                              const CustomText(
                                textAlign: TextAlign.start,
                                title:
                                    "Ai is the future of the world kindly focus on Ai Skills if you want to successfull in future",
                              ),
                            ],
                          ),
                        );
                      }),
            ),
          ],
        ),
      )),
    );
  }
}
