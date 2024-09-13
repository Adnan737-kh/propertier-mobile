import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Language/View/component/language_search_text_field.dart';
import 'package:propertier/App/Language/ViewModel/language_view_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/appbar.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

class LanguageView extends StatelessWidget {
  LanguageView({super.key});
  final viewModel = Get.find<LanguageViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return SafeArea(
            child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: context.getSize.width * 0.060),
          child: Column(
            children: [
              getHeight(context, 0.040),
              customAppBar(
                context: context,
                onTap: () {
                  Get.back();
                },
                title: context.local.language,
              ),
              getHeight(context, 0.045),
              LanguageSearchTextField(
                  voidCallBack: (val) {
                    viewModel.getLanguageBySearch(query: val);
                  },
                  searchController: viewModel.searchController,
                  suFixIcon: const SizedBox.shrink()),
              ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: List.generate(
                    viewModel.searchList.isNotEmpty
                        ? viewModel.searchList.length
                        : viewModel.langaugesList.length, (index) {
                  LanguageModel language = viewModel.searchList.isNotEmpty
                      ? viewModel.searchList[index]
                      : viewModel.langaugesList[index];
                  return GestureDetector(
                    onTap: () {
                      viewModel.switchLanguage(
                          languageCode: language.code,
                          index: index,
                          languageName: language.language);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: AppColor.blackColor,
                        width: 1,
                      ))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getHeight(context, 0.015),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              appText(
                                  title: language.language,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  context: context),
                              getWidth(context, 0.020),
                              viewModel.selectedLanguageIndex == index
                                  ? const Icon(Icons.check,
                                      color: Color(0xff1478BE))
                                  : const SizedBox.shrink(),
                            ],
                          ),
                          appText(
                              title: language.countryName,
                              fontSize: 12,
                              fontWeight: FontWeight.w200,
                              colorOpecity: 0.2,
                              context: context),
                          getHeight(context, 0.008),
                        ],
                      ),
                    ),
                  );
                }),
              )
            ],
          ),
        ));
      }),
    );
  }
}
