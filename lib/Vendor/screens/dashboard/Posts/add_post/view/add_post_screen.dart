import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:propertier/Vendor/screens/dashboard/Posts/Feature_ad_payment/View/feature_ad_payment_screen.dart';
import 'package:propertier/Vendor/screens/dashboard/Posts/add_post/Controller/add_post_controller.dart';
import 'package:propertier/constant/colors.dart';
import 'package:video_player/video_player.dart';

import '../../../../../../App/Post Add/Add Properties/Components/video_tour.dart';
import '../../../../../../App/Post Add/Add Properties/Views/add_properties_view.dart';
import '../../../../../../Utils/app_text.dart';
import '../../../../../../Utils/height_width_box.dart';
import '../../../../../../constant/AppButton/text_button.dart';
import '../../../../../../constant/AppTextField/app_textfield.dart';
import '../../../../../../constant/custom_drop_down.dart';
import '../../../../../../constant/toast.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  var getThumbnail = "";
  final PostController postController = Get.find<PostController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostController>(
      builder: (postController) {
        return  postController.category == null
            ? const Center(child: CircularProgressIndicator())
            : Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF131A22),
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            actions: [
              TextButton(
                onPressed: () async {},
                child: const Text(
                  'Done',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
            title: const Text(
              'Post Ad',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if (postController.category == 'architect') _architectForm(),
                if (postController.category == 'domestic_and_professional') _domesticAndProfessional(),
                if (postController.category == 'water_provider') _waterProviderServicesForm(),
                if (postController.category == 'general') _generaServicesForm(),
                if (postController.category == 'transport') _transportServicesForm(),
              ],
            ),
          ),
        );
      },
    );

  }

  Widget _architectForm() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCommonPostFields(
                context: context,
                pricingModelItems: postController.priceModelForArchitect,
              ),


              const Divider(color: Color(0xFFCFCFCF)),
              const SizedBox(height: 22),
              buildMediaUploadSection(
                context,
                    (thumb) {
                  setState(() {
                    getThumbnail = thumb;
                  });
                },
                getThumbnail,
              ),
              const SizedBox(height: 34),
              buildFeatureAdPrompt(),
              SizedBox(height: Get.height * .048),
              _buildPostActionButtons(
                onClearAll: () {},
                onSavePost: () {
                    postController.submitPost();
                },
              ),
              SizedBox(height: Get.height * .03),
            ],
          ),
        ),
      ],
    );
  }
  Widget _domesticAndProfessional() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCommonPostFields(
                context: context,
                pricingModelItems: postController.priceModelForDomesticAndProfessional),
              const SizedBox(height: 18),

              CustomDropDown(
                  items: postController.toolsProvide,
                  observableSelectedValue: postController.toolProvideSelectedItem,
                  hintText: 'Select Tools Provided',
                  labelText: 'Tools Provided:',
                  itemToString: (s) => s
              ),
              const SizedBox(height: 18),
              customTextButton(
                  onTap: () {
                    postController.openAvailabilityDialog(context);},
                  title: 'Availability Schedule'),
              const SizedBox(height: 22),
              const Divider(color: Color(0xFFCFCFCF)),
              const SizedBox(height: 18),
              buildMediaUploadSection(
                context,
                    (thumb) {
                  setState(() {
                    getThumbnail = thumb;
                  });
                },
                getThumbnail,
              ),
              const SizedBox(height: 34),
              buildFeatureAdPrompt(),
              SizedBox(height: Get.height * .048),
              _buildPostActionButtons(
                onClearAll: () {},
                onSavePost: () {
                  postController.submitPost();
                },
              ),
              SizedBox(height: Get.height * .03),
            ],
          ),
        ),
      ],
    );
  }
  Widget _waterProviderServicesForm() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCommonPostFields(
                context: context,
                pricingModelItems: postController.priceModelForWaterProvider),
              const SizedBox(height: 18),
              CustomDropDown(
                items:  postController.waterTypes,
                observableSelectedValue: postController.waterTypesSelectedItem,
                hintText: 'Select Water Type',
                labelText: 'Water Types:',
                itemToString: (s) => s,
              ),
              const SizedBox(height: 18),
              CustomDropDown(
                items:  postController.waterDeliveryTypes,
                observableSelectedValue: postController.waterDeliverySelectedItem,
                hintText: 'Select Delivery Type',
                labelText: 'Delivery Types:',
                itemToString: (s) => s,
              ),
              const SizedBox(height: 18),
              const SizedBox(height: 22),
              const Divider(color: Color(0xFFCFCFCF)),
              const SizedBox(height: 18),
              buildMediaUploadSection(
                context,
                    (thumb) {
                  setState(() {
                    getThumbnail = thumb;
                  });
                },
                getThumbnail,
              ),
              const SizedBox(height: 34),
              buildFeatureAdPrompt(),
              SizedBox(height: Get.height * .048),
              _buildPostActionButtons(
                onClearAll: () {},
                onSavePost: () {
                  postController.submitPost();
                },
              ),
              SizedBox(height: Get.height * .03),
            ],
          ),
        ),
      ],
    );
  }
  Widget _generaServicesForm() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //common fields
              _buildCommonPostFields(
                context: context,
                pricingModelItems: postController.priceModelForWaterProvider),

              const SizedBox(height: 18),
              const SizedBox(height: 22),
              const Divider(color: Color(0xFFCFCFCF)),
              const SizedBox(height: 18),
              buildMediaUploadSection(
                context,
                    (thumb) {
                  setState(() {
                    getThumbnail = thumb;
                  });
                },
                getThumbnail,
              ),
              const SizedBox(height: 34),
              buildFeatureAdPrompt(),
              SizedBox(height: Get.height * .048),
              _buildPostActionButtons(
                onClearAll: () {},
                onSavePost: () {
                  postController.submitPost();
                },              ),
              SizedBox(height: Get.height * .03),
            ],
          ),
        ),
      ],
    );
  }
  Widget _transportServicesForm() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCommonPostFields(
                  context: context,
                  pricingModelItems: postController.priceModelForDomesticAndProfessional,
                  isPriceModel: false,
                  isVisitingCharges: false),
              const SizedBox(height: 18),
              customTextButton(
                  onTap: () {
                    postController.openAvailabilityDialog(context);},
                  title: 'Availability Schedule'),
              const SizedBox(height: 22),
              const Divider(color: Color(0xFFCFCFCF)),
              const SizedBox(height: 18),
              buildMediaUploadSection(
                context,
                    (thumb) {
                  setState(() {
                    getThumbnail = thumb;
                  });
                },
                getThumbnail,
              ),
              const SizedBox(height: 34),
              buildFeatureAdPrompt(),
              SizedBox(height: Get.height * .048),
              _buildPostActionButtons(
                onClearAll: () {},
                onSavePost: () {
                  postController.submitPost();
                },              ),
              SizedBox(height: Get.height * .03),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTitleTextField(
      BuildContext context, TextEditingController controller) {
    return customTextField(
      controller: controller,
      hintText: 'Title',
      fillColor: const Color(0x05131A22),
      isFilled: true,
    );
  }

  Widget _buildDescriptionField(
      BuildContext context, TextEditingController controller) {
    return customTextField(
      controller: controller,
      hintText: 'Description',
      fillColor: const Color(0x05131A22),
      isFilled: true,
      maxLines: 5,
    );
  }

  Widget _buildServiceChargesSection({
    required bool isVisit,
    required TextEditingController serviceChargesController,
    required List<String> serviceChargesItems,
    required Rx<String?> selectedServiceCharge,
    required ValueChanged<bool> onSwitchChanged,
    required Function(String?) onDropdownChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Service Charges:',
          style: TextStyle(
            color: Color(0xFF131A22),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        isVisit
            ? customTextField(
                controller: serviceChargesController,
                hintText: 'Enter Service Charges',
                fillColor: const Color(0x05131A22),
                isFilled: true,
              )
            : CustomDropDown(
                items: serviceChargesItems,
                observableSelectedValue: selectedServiceCharge,
                otherFieldController: serviceChargesController,
                itemToString: (s) => s,
                hintText: 'Enter Service Charges',
              ),
      ],
    );
  }

  Widget _buildImageUploadSection({
    required BuildContext context,
    required RxList<File?> images,
    required VoidCallback onAddImage,
    required VoidCallback onRemoveLastImage,
  }) {
    return Obx(() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Upload Image:',
                style: TextStyle(
                  color: Color(0xFF272E36),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: MediaQuery.of(context).size.height * .2,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: images.map((image) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: image != null
                            ? Image.file(
                                image,
                                width: 200,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
                                fit: BoxFit.cover,
                              ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  if (images.isNotEmpty)
                    Container(
                      width: 48,
                      height: 48,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.delete,
                            color: Colors.red, size: 28),
                        onPressed: onRemoveLastImage,
                      ),
                    ),
                  const SizedBox(width: 10),
                  Container(
                    width: 48,
                    height: 48,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add, size: 28),
                      onPressed: onAddImage,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              const Divider(color: Colors.black45),
            ],
          ),
        ));
  }

  Widget _buildVideoUploadSection({
    required BuildContext context,
    required TextEditingController urlController,
    required RxBool showVideo,
    required void Function(String thumbnailUrl) onThumbnailGenerated,
    required String getThumbnail,
    required VoidCallback showToast,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: "Upload Video",
          fontSize: 18,
          fontWeight: FontWeight.normal,
        ),
        getHeight(context, 0.015),
        Obx(() => showVideo.value
            ? AddVideoPlayer(
                videoUrl: urlController.text,
                thumbnail: getThumbnail,
              )
            : const Gap(0)),
        getHeight(context, 0.015),
        CustomAddTextField(
          textEditingController: urlController,
          border: InputBorder.none,
          labelText: "Paste Video Url here",
          onChanged: (url) {
            try {
              final videoId = YoutubePlayerController.convertUrlToId(url);
              if (videoId != null) {
                final thumbnail =
                    YoutubePlayerController.getThumbnail(videoId: videoId);
                onThumbnailGenerated(thumbnail);
                showVideo.value = true;
              }
            } catch (e) {
              showToast();
            }
          },
          suffixIcon: IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              try {
                final videoId =
                    YoutubePlayerController.convertUrlToId(urlController.text);
                if (videoId != null) {
                  final thumbnail = YoutubePlayerController.getThumbnail(
                    videoId: videoId,
                  );
                  onThumbnailGenerated(thumbnail);
                  showVideo.value = true;
                }
              } catch (e) {
                showToast();
              }
            },
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter URL';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildUploadShortVideo({
    required Rx<File?> selectedVideo,
    required Rx<VideoPlayerController?> videoController,
    required RxBool isPlaying,
    required VoidCallback onPickVideo,
    required VoidCallback onDeleteVideo,
    required VoidCallback onTogglePlayPause,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Upload Short Video:',
            style: TextStyle(
              color: Color(0xFF272E36),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            width: double.infinity,
            height: Get.height * 0.5,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Obx(() => Positioned.fill(
                      child: selectedVideo.value == null
                          ? Center(
                              child: GestureDetector(
                                onTap: onPickVideo,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.video_call,
                                      size: 38,
                                      color: Color(0xFFB3B3B3),
                                    ),
                                    SizedBox(height: 7),
                                    Text(
                                      'Upload Short Video Less Than 25MB',
                                      style: TextStyle(
                                        color: Color(0xFFB3B3B3),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Stack(
                              children: [
                                if (videoController.value != null &&
                                    videoController.value!.value.isInitialized)
                                  Positioned.fill(
                                    child: AspectRatio(
                                      aspectRatio: videoController
                                          .value!.value.aspectRatio,
                                      child:
                                          VideoPlayer(videoController.value!),
                                    ),
                                  ),
                                if (!isPlaying.value)
                                  const Center(
                                    child: Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                  ),
                              ],
                            ),
                    )),
                Obx(() => selectedVideo.value != null
                    ? Positioned(
                        top: 16,
                        right: 16,
                        child: GestureDetector(
                          onTap: onDeleteVideo,
                          child: Container(
                            width: 34,
                            height: 34,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFF7F7F7),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(45),
                              ),
                            ),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink()),
              ],
            ),
          ),
          Obx(() => selectedVideo.value != null
              ? Center(
                  child: IconButton(
                    icon: Icon(
                      isPlaying.value ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                    ),
                    onPressed: onTogglePlayPause,
                  ),
                )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }

  Widget buildFeatureAdPrompt() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Center(
          child: Text(
            'Do your wanna Feature your ad?',
            style: TextStyle(
              color: Color(0xFFB3B3B3),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: InkWell(
            onTap: () {
              Get.to(() => const FeatureAdPaymentScreen());
            },
            child: const Text(
              'Feature Ad',
              style: TextStyle(
                color: Color(0xFF109B0E),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPostActionButtons({
    required VoidCallback onClearAll,
    required VoidCallback onSavePost,
  }) {
    return Container(
      height: 49,
      padding: const EdgeInsets.all(8),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 4,
            offset: Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: customTextButton(
              height: 33,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: AppColor.greenColor,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              title: 'Clear All',
              onTap: onClearAll,
              textColor: AppColor.greenColor,
              fontSize: 14,
              buttonColor: AppColor.white,
            ),
          ),

          const SizedBox(width: 10),
          Expanded(
            child: customTextButton(
              height: 33,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: ShapeDecoration(
                color: const Color(0xFFFDCD54),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    width: 0.40,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Color(0x19131A22),
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
                title: 'Save Post',
                onTap: onSavePost,
              textColor: AppColor.blackColor,
              fontSize: 14,
              buttonColor: const Color(0xFFFDCD54),
            ),
          ),

        ],
      ),
    );
  }


  Widget _buildCommonPostFields({
    required BuildContext context,
    required List<String> pricingModelItems,
    bool isPriceModel = true,
    bool isVisitingCharges = true,
  }) {
    final postController = Get.find<PostController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 33),
        _buildTitleTextField(context, postController.titleController),
        const SizedBox(height: 18),
        _buildDescriptionField(context, postController.descriptionController),
        const SizedBox(height: 18),
        (isPriceModel== false)?const SizedBox():
        CustomDropDown(
          items: pricingModelItems,
          observableSelectedValue: postController.priceModelSelectedItem,
          hintText: 'Select Pricing Model',
          labelText: 'Pricing Model:',
          itemToString: (s) => s,
        ),
        const SizedBox(height: 18),

        _buildServiceChargesSection(
          isVisit: postController.isVisit.value,
          serviceChargesController: postController.serviceChargesController,
          serviceChargesItems: postController.serviceChargesItems,
          selectedServiceCharge: postController.selectedServiceCharge!,
          onSwitchChanged: (value) {
            postController.isVisit.value = value;
            if (!value) {
              postController.serviceChargesController.clear();
            }
          },
          onDropdownChanged: (value) {
            postController.selectedServiceCharge?.value = value!;
            postController.serviceChargesController.text = value!;
            postController.update();
          },
        ),
        const SizedBox(height: 18),

        (isVisitingCharges== false)?const SizedBox():
        CustomDropDown(
          items: postController.visitingChargesItems,
          observableSelectedValue: postController.visitingChargesSelectedItem,
          otherFieldController: postController.visitingChargesController,
          itemToString: (s) => s,
          hintText: 'Select Visiting Charge',
          labelText: 'Visiting Charges:',
          otherHintText: 'Visiting Charges:',
          otherValue: 'Other',
          showOtherTextField: true,
        ),
        const SizedBox(height: 18),

        CustomDropDown(
          items: postController.servicesRadiusItems,
          observableSelectedValue: postController.servicesRadiusSelectedItem,
          hintText: 'Select Services Radius',
          labelText: 'Services Radius:',
          itemToString: (s) => s,
        ),
      ],
    );
  }

  Widget buildMediaUploadSection(BuildContext context,
      void Function(String) updateThumbnail, String getThumbnail) {
    final postController = Get.find<PostController>(); // or inject your controller

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImageUploadSection(
          context: context,
          images: postController.images,
          onAddImage: () => postController.pickImages(context),
          onRemoveLastImage: postController.removeLastImage,
        ),
        const SizedBox(height: 44),
        _buildVideoUploadSection(
          context: context,
          urlController: postController.youtubeVideoUrlController,
          showVideo: postController.showVideo,
          getThumbnail: getThumbnail,
          onThumbnailGenerated: (thumb) {
            updateThumbnail(thumb);
          },
          showToast: () => toast(title: "Invalid video URL", context: context),
        ),
        const SizedBox(height: 44),
        _buildUploadShortVideo(
          selectedVideo: postController.selectedVideo,
          videoController: postController.videoController,
          isPlaying: postController.isPlaying,
          onPickVideo: () => postController.pickVideo(context),
          onDeleteVideo: postController.deleteVideo,
          onTogglePlayPause: postController.togglePlayPause,
        ),
      ],
    );
  }
}
