import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:propertier/Customer/screens/PropertyServiceForm/PropertyServiceFormController.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';
import '../../../App/ServicesSearch/View/component/description_text_field.dart';
import '../../../App/ServicesSearch/View/component/upload_work_photos_tile.dart';
import '../../../App/ServicesSearch/View/component/custom_textfield.dart';
import '../../../RoutesAndBindings/app_routes.dart';
import '../../../Utils/app_text.dart';
import '../../../Utils/appbar.dart';
import '../../../Utils/box_shadow.dart';
import '../../../Utils/divider.dart';
import '../../../Utils/height_width_box.dart';
import '../../../Utils/textStyle.dart';
import '../../../Utils/text_botton.dart';
import '../../../constant/colors.dart';
import '../../../constant/constant.dart';

class PropertyServiceForm extends GetView<PropertyServiceFormController> {
  const PropertyServiceForm({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(alignment: Alignment.topCenter, children: [
          Image.asset(
            Constant.curve,
            width: context.getSize.width,
          ),
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.getSize.width * 0.09),
              child: Column(
                children: [
                  getHeight(context, 0.050),
                  customAppBar(
                      context: context,
                      onTap: () {
                        Get.back();
                      }),
                  getHeight(context, 0.04),
                  getHeight(context, 0.015),
                  SvgPicture.asset(
                    Constant.servicesSearchIcon,
                    height: 100,
                    width: 86,
                  ),
                  getHeight(context, 0.01),
                  CustomText(
                      title: context.local.property,
                      fontSize: 18,
                      colorOpecity: 0.6,
                      fontWeight: FontWeight.w500,
                      ),
                  getHeight(context, 0.01),
                  Column(
                    children: [
                      InstaImageViewer(
                        imageUrl: Constant.dummyImage2,
                        child: Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.only(
                              left: 36,
                              right: 36,
                              top: context.getSize.height * 0.050),
                          width: context.getSize.width,
                          height: context.getSize.height * 0.20,
                          decoration: BoxDecoration(
                              // border: Border.all(width: 5),
                              boxShadow: [boxShadow()],
                              image: const DecorationImage(
                                  image: NetworkImage(Constant.dummyImage2),
                                  fit: BoxFit.cover)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox.shrink(),
                              GestureDetector(
                                onTap: () {},
                                child: const Icon(
                                  Icons.share,
                                  color: AppColor.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 36),
                        width: context.getSize.width,
                        decoration: BoxDecoration(
                            color: AppColor.white,
                            boxShadow: [boxShadow()],
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            )),
                        // height: context.getSize.height * 0.12,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomText(
                                    title: context.local.sub_service_name,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                                getWidth(context, 0.010),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColor.buttonColor),
                                  child: Icon(
                                    Icons.check,
                                    size: context.getSize.width * 0.03,
                                    color: AppColor.blackColor,
                                  ),
                                )
                              ],
                            ),
                            getHeight(context, 0.010),
                            Align(
                              alignment: Alignment.centerRight,
                              child: RatingBarIndicator(
                                rating: 4,
                                unratedColor: AppColor.greenColor,
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: context.getSize.width * 0.034,
                                direction: Axis.horizontal,
                              ),
                            ),
                            getHeight(context, 0.020),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: CustomText(
                                  colorOpecity: 0.6,
                                  title: context.local.sub_service_short_description,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  getHeight(context, 0.016),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getHeight(context, 0.01),
                      divider(
                          context: context,
                          color: AppColor.blackColor.withOpacity(0.75)),
                      getHeight(context, 0.015),
                      CustomText(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          title: context.local.upload_work_photo,
                          ),
                      getHeight(context, 0.008),
                      const UploadWorkPhotosTile(),
                      getHeight(context, 0.015),
                      const CustomText(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          title: "Brief Overview",
                          ),
                      CustomTextField(
                          controller: controller.overviewController),
                      getHeight(context, 0.008),
                      getHeight(context, 0.015),
                      const CustomText(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          title: "Address Detail (Street, House/Office No)",
                           ),
                      CustomTextField(controller: controller.addressController),
                      getHeight(context, 0.015),
                      // Property LOCATION
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                              title:context.local.property_location, ),
                          TextButton(
                              onPressed: () {
                                controller.places.clear();
                                Get.to(const SelectLocation(isPickup: false));
                              },
                              child:  Text(context.local.select))
                        ],
                      ),
                      Obx(() => controller.dropLocation.value != null
                          ? CustomText(
                              title: controller.dropLocation.value,
                               )
                          : CustomText(
                              title: context.local.not_selected,
                              fontSize: 12)),
                      getHeight(context, 0.008),
                      const Divider(),
                      getHeight(context, 0.008),
                      // DATE TIME PICKER
                      getHeight(context, 0.008),
                      Obx(() => DropdownButton<String>(
                            value: controller.selectedDeliveryTime.value,
                            hint: const Text('Delivery Time'),
                            isExpanded:
                                true, // Ensures dropdown takes full width
                            items: <String>['Deliver Now', 'In Future']
                                .map((String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    ))
                                .toList(),
                            onChanged: (String? newValue) {
                              controller.selectedDeliveryTime.value = newValue;
                            },
                            style: const TextStyle(
                                fontSize: 14,
                                color: AppColor
                                    .blackColor), // Customize text style
                          )),
                      getHeight(context, 0.008),
                      // DATE TIME PICKER
                      Obx(() => controller.selectedDeliveryTime.value ==
                              "In Future"
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                        title: context.local.date_time, ),
                                    TextButton(
                                        onPressed: () {
                                          controller
                                              .showDateTimePicker(context);
                                        },
                                        child: const Text("Select"))
                                  ],
                                ),
                                Obx(() => controller.dateTime.value != null
                                    ? Text(controller.dateTime.value.toString())
                                    : CustomText(
                                        title:context.local.not_selected,
                                        fontSize: 12)),
                              ],
                            )
                          : const SizedBox()),
                      getHeight(context, 0.015),
                      CustomText(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          title: context.local.description_about_your_work,),
                      getHeight(context, 0.008),
                      DescriptionTextField(
                        descriptionController: controller.descriptionController,
                      ),
                      getHeight(context, 0.024),
                      textButton(
                          textFontSize: 20,
                          textFontWeight: FontWeight.w500,
                          context: context,
                          title: 'Offer to Vendor',
                          onClick: () {
                            Get.toNamed(AppRoutes.vendorOffer);
                          })
                    ],
                  )
                ],
              )),
        ]),
      ),
      // floatingActionButton: FloatingActionButton(onPressed: ()async{
      //   String data = await controller.getDistanceInKm(startLatitude: controller.startPosition!.latitude,startLongitude: controller.startPosition!.longitude,endLatitude: controller.endPosition!.latitude, endLongitude: controller.endPosition!.latitude);
      //   print(data);
      // }, child: Icon(Icons.add),),
    );
  }
}

class SelectLocation extends StatelessWidget {
  const SelectLocation({super.key, required this.isPickup});
  final bool isPickup;
  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();
    TextEditingController searchAddressTextController = TextEditingController();
    PropertyServiceFormController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back, color: AppColor.blackColor)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 54,
                // width: context.width * 0.688,
                child: TextFormField(
                  focusNode: focusNode,
                  controller: searchAddressTextController,
                  style: textStyle(context: context, fontSize: 12),
                  decoration: InputDecoration(
                    suffixIcon: searchAddressTextController.text == ""
                        ? const Icon(
                            Icons.search,
                          )
                        : GestureDetector(
                            onTap: () {
                              searchAddressTextController.text = "";
                            },
                            child: const Icon(
                              Icons.close,
                            ),
                          ),
                    hintText: "Search here...",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none),
                    fillColor: AppColor.darkGreyColor.withOpacity(0.2),
                    filled: true,
                  ),
                  onChanged: (value) {
                    controller.searchPlaces(value);
                  },
                ),
              ),
              getHeight(context, 0.020),
              CustomText(
                  title: context.local.locations,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,),
              getHeight(context, 0.020),
              DestinationSection(
                isPickup: isPickup,
              ),
              getHeight(context, 0.020),
            ],
          ),
        ),
      ),
    );
  }
}

class DestinationSection extends StatelessWidget {
  DestinationSection({super.key, required this.isPickup});
  final bool isPickup;
  final PropertyServiceFormController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: controller.places.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return loctionTile(
            context: context,
            tile: controller.places[index].description,
            onTap: () async {
              controller.dropLocation.value =
                  controller.places[index].description;
              controller.endPosition = LatLng(
                  controller.places[index].latitude ?? 0.0,
                  controller.places[index].longitude ?? 0.0);
              Get.back();
            },
          );
        },
      ),
    );
  }

  InkWell loctionTile(
      {required BuildContext context,
      required String tile,
      Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          getHeight(context, 0.02),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: context.width * 0.8,
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomText(
                              title: tile,
                              fontSize: 16,
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.normal,
                              colorOpecity: 0.7,
                              ),
                        )
                      ],
                    )),
                Image.asset(
                  Constant.tick,
                  height: 20,
                ),
              ],
            ),
          ),
          getHeight(context, 0.01),
          divider(context: context, withOpacity: 0.2)
        ],
      ),
    );
  }
}
