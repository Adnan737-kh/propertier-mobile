import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:propertier/Vendor/screens/dashboard/Posts/Feature_ad_payment/View/feature_ad_payment_screen.dart';
import 'package:propertier/Vendor/screens/dashboard/Posts/add_post/Controller/add_post_controller.dart';
import 'package:propertier/Vendor/screens/dashboard/Posts/add_post/Model/add_post_model.dart';
import 'package:propertier/Vendor/screens/dashboard/Posts/add_post/Model/title_model.dart';
import 'package:propertier/Vendor/screens/dashboard/Posts/select_category/Controller/select_category_controller.dart';
import 'package:propertier/Vendor/screens/dashboard/Posts/select_category/View/select_category.dart';
import 'package:video_player/video_player.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  String? parentId;
  String? _selectedItem1;
  String? _selectedServiceCharge;
  String? selectedCategory;
  TitleModel? _selectedServices;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _visitingChargesController =
      TextEditingController();
  final TextEditingController _serviceChargesController =
      TextEditingController();
  final TextEditingController _subservicesController = TextEditingController();
  final PostController _postController = PostController();
  final SelectCategoryController controller =
      Get.put(SelectCategoryController());

  @override
  void dispose() {
    _serviceChargesController.dispose();
    super.dispose();
  }

  void _savePost() async {
    print("Save Post button pressed");

    final String title = _titleController.text;
    final String visitingCharges = _visitingChargesController.text;

    final box = GetStorage();
    String? vendorUserId = box.read('vendorUserId');

    if (vendorUserId == null) {
      Get.snackbar('Error', 'Vendor ID could not be retrieved.');
      return;
    }
    // print('Vendor ID retrieved: $vendorUserId');

    String fixedPriceValue =
        isVisit ? _serviceChargesController.text : _selectedServiceCharge ?? '';

    if (!_validateFields(title, visitingCharges, fixedPriceValue)) return;

    final postModel = AddPostModel(
      vendorId: vendorUserId,
      serviceId: parentId ?? '',
      title: title,
      selectedSubServices: [_selectedServices?.id ?? ''],
      images: [],
      videoUrl: '',
      shortVideo: '',
      visitingCharges: visitingCharges,
      fixedPrice: fixedPriceValue,
    );

    await _postController.addPost(postModel, _selectedImage, _selectedVideo);
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar('Error', message);
  }

// Function to validate all the necessary fields
  bool _validateFields(
      String title, String visitingCharges, String fixedPriceValue) {
    if (selectedCategory == null) {
      _showErrorSnackbar('Select Category First');
      return false;
    }
    if (title.isEmpty) {
      _showErrorSnackbar('Title is not Empty');
      return false;
    }
    if (visitingCharges.isEmpty) {
      _showErrorSnackbar('Please enter visiting Charges');
      return false;
    }
    if (fixedPriceValue.isEmpty) {
      _showErrorSnackbar('No service charges selected or entered');
      return false;
    }
    if (_selectedServices == null) {
      _showErrorSnackbar('Please Select Service Type from Services');
      return false;
    }
    if (_selectedImage == null) {
      _showErrorSnackbar('No image selected');
      return false;
    }
    if (_selectedVideo == null) {
      _showErrorSnackbar('No video selected');
      return false;
    }
    return true;
  }

  final List<String> _dropdownItems1 = [
    '300',
    '400',
    '500',
    '600',
    '700',
    '800',
    '900'
  ];
  File? _selectedVideo;

  VideoPlayerController? _videoController;
  bool _isPlaying = false;

  Future<void> _pickVideo() async {
    // print("Pick Video function called"); // Debug print statement

    final picker = ImagePicker();
    final XFile? video = await picker.pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(seconds: 60),
    );

    if (video != null) {
      final fileSizeInBytes = await video.length();
      final fileSizeInMB = fileSizeInBytes / (1024 * 1024);

      if (fileSizeInMB > 25) {
        print(
            "Selected video size is too large: ${fileSizeInMB.toStringAsFixed(2)} MB");
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Video Size Exceeded"),
              content: Text(
                  "The selected video size is ${fileSizeInMB.toStringAsFixed(2)} MB. The maximum allowed size is 25 MB."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      } else {
        setState(() {
          _selectedVideo = File(video.path); // Save the full video file

          _videoController = VideoPlayerController.file(_selectedVideo!)
            ..initialize().then((_) {
              setState(() {}); // Refresh to show video thumbnail
            });

          print("Selected video saved: $_selectedVideo");
        });
      }
    } else {
      print("No video selected or user canceled the picker.");
    }
  }

  void _deleteVideo() {
    setState(() {
      _selectedVideo = null;
      _videoController?.dispose();
      _videoController = null;
      _isPlaying = false;
    });
  }

  void _togglePlayPause() {
    if (_videoController != null) {
      setState(() {
        if (_isPlaying) {
          _videoController!.pause();
        } else {
          _videoController!.play();
        }
        _isPlaying = !_isPlaying;
      });
    }
  }

  File? _selectedImage;

  Future<void> _pickImage() async {
    print("Pick Image function called");

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final fileSizeInBytes = await pickedFile.length();
      final fileSizeInMB = fileSizeInBytes / (1024 * 1024);

      if (fileSizeInMB > 2) {
        print(
            "Selected image size is too large: ${fileSizeInMB.toStringAsFixed(2)} MB");
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Image Size Exceeded"),
              content: Text(
                  "The selected image size is ${fileSizeInMB.toStringAsFixed(2)} MB. The maximum allowed size is 2 MB."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      } else {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
        print("Selected image saved: $_selectedImage");
      }
    } else {
      print("No image selected or user canceled the picker.");
    }
  }

  void _deleteImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  bool isVisit = false;
  bool isService = false;
  void _openSelectCategoryScreen() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    await controller.fetchParentServices();

    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
    print('Fetched Parent Services Map: ${controller.parentServicesMap}');

    final String? selected = await showModalBottomSheet<String?>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return SelectCategory(
          category: selectedCategory ?? '',
          onCategorySelected: (category) async {
            if (category != null) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) =>
                    Center(child: CircularProgressIndicator()),
              );

              print('Selected Category: $category');
              await controller.fetchTitlesForParentService(category);
              print('Fetched Titles for $category:');

              controller.titles.forEach((titleModel) {
                print('Title: ${titleModel.title}, ID: ${titleModel.id}');
              });

              setState(() {
                parentId = controller.selectedParentServiceId.value;
                selectedCategory = category;
              });

              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            }
          },
          parentServices: controller.parentServicesMap.keys.toList(),
        );
      },
    );

    if (selected != null) {
      print('Selected Parent Service ID after modal: $parentId');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF131A22),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actions: [
          TextButton(
            onPressed: () {},
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
            Container(
              height: Get.height * .069,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: const ShapeDecoration(
                color: Color(0xFF131A22),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * .048,
                    child: TextFormField(
                      cursorColor: Colors.amber,
                      readOnly: true,
                      onTap: _openSelectCategoryScreen,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(33),
                          borderSide: const BorderSide(color: Colors.black12),
                        ),
                        hintText: selectedCategory ?? 'Select category',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(33),
                        ),
                        hintStyle: const TextStyle(
                          color: Color(0xFF828A89),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        isDense: true,
                        suffixIcon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 22,
                              width: 22,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFDCD54),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 33,
                  ),
                  TextFormField(
                    controller: _titleController,
                    cursorColor: Colors.amber,
                    decoration: InputDecoration(
                      fillColor: const Color(0x05131A22),
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.020,
                        horizontal: 8,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(color: Color(0x05131A22)),
                      ),
                      hintText: 'Title',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(color: Color(0x05131A22)),
                      ),
                      hintStyle: const TextStyle(
                        color: Color(0x66131A22),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      isDense: true,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Description:',
                    style: TextStyle(
                      color: Color(0xFF131A22),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  TextFormField(
                    controller: _descriptionController,
                    cursorColor: Colors.amber,
                    maxLines: 5,
                    decoration: InputDecoration(
                      fillColor: const Color(0x05131A22),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(color: Color(0x05131A22)),
                      ),
                      hintText: 'Detail Description',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(color: Color(0x05131A22)),
                      ),
                      hintStyle: const TextStyle(
                        color: Color(0x66131A22),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      isDense: true,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(
                    height: 18,
                  ),
                  const Text(
                    'Visiting Charges:',
                    style: TextStyle(
                      color: Color(0xFF131A22),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    height: Get.height * .06,
                    child: DropdownButtonFormField<String>(
                      value: _selectedItem1,
                      // hint: const Text('300'),
                      decoration: InputDecoration(
                        fillColor: const Color(0x05131A22),
                        filled: true,
                        isDense: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide:
                              const BorderSide(color: Color(0x05131A22)),
                        ),
                        // hintText: 'Visiting Charges',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide:
                              const BorderSide(color: Color(0x05131A22)),
                        ),
                      ),
                      style: const TextStyle(
                        color: Color(0x66131A22),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      isExpanded: true,
                      items: _dropdownItems1
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedItem1 = value;
                          _visitingChargesController.text = value ?? '';
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Price Fixed?',
                        style: TextStyle(
                          color: Color(0xFF3498DB),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      CupertinoSwitch(
                        activeColor: const Color(0xFF3498DB),
                        value: isVisit,
                        onChanged: (value) {
                          setState(() {
                            isVisit = value;
                            if (!isVisit) {
                              _serviceChargesController
                                  .clear(); // Clear the manual input when the switch is turned off
                            }
                          });
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Service Charges:',
                    style: TextStyle(
                      color: Color(0xFF131A22),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    height: Get.height * .06,
                    child: isVisit
                        ? TextFormField(
                            controller: _serviceChargesController,
                            decoration: InputDecoration(
                              hintText: 'Enter Service Charges',
                              fillColor: const Color(0x05131A22),
                              filled: true,
                              isDense: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide:
                                    const BorderSide(color: Color(0x05131A22)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide:
                                    const BorderSide(color: Color(0x05131A22)),
                              ),
                            ),
                            style: const TextStyle(
                              color: Color(0x66131A22),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        : DropdownButtonFormField<String>(
                            value: _selectedServiceCharge,
                            decoration: InputDecoration(
                              fillColor: const Color(0x05131A22),
                              filled: true,
                              isDense: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide:
                                    const BorderSide(color: Color(0x05131A22)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide:
                                    const BorderSide(color: Color(0x05131A22)),
                              ),
                            ),
                            style: const TextStyle(
                              color: Color(0x66131A22),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            isExpanded: true,
                            items: _dropdownItems1
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedServiceCharge = value;
                              });
                            },
                          ),
                  ),

                  const SizedBox(
                    height: 18,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     const Text(
                  //       'Price Fixed?',
                  //       style: const TextStyle(
                  //         color: Color(0xFF3498DB),
                  //         fontSize: 12,
                  //         fontWeight: FontWeight.w400,
                  //       ),
                  //     ),
                  //     CupertinoSwitch(
                  //       activeColor: const Color(0xFF3498DB),
                  //       value: isVisit,
                  //       onChanged: (value) {
                  //         setState(() {
                  //           isVisit = value;
                  //         });
                  //       },
                  //     )
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 14,
                  // ),
                  const Text(
                    'Services:',
                    style: TextStyle(
                      color: Color(0xFF131A22),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    height: Get.height * .06,
                    child: DropdownButtonFormField<TitleModel>(
                      value: _selectedServices,
                      hint: const Text('Select Service'),
                      decoration: InputDecoration(
                        fillColor: const Color(0x05131A22),
                        filled: true,
                        isDense: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide:
                              const BorderSide(color: Color(0x05131A22)),
                        ),
                        hintText: 'Select Service',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide:
                              const BorderSide(color: Color(0x05131A22)),
                        ),
                      ),
                      style: const TextStyle(
                        color: Color(0x66131A22),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      isExpanded: true,
                      items: controller.titles
                          .map((item) => DropdownMenuItem<TitleModel>(
                                value: item,
                                child: Text(item.title),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedServices =
                              value; // Update the selected service
                          _subservicesController.text = value?.title ?? '';
                          if (value != null) {
                            print('Selected Title: ${value.title}');
                            print('Selected ID: ${value.id}');
                          }
                        });
                      },
                    ),
                  ),

                  const SizedBox(
                    height: 12,
                  ),
                  const SizedBox(height: 4),
                  const SizedBox(
                    height: 12,
                  ),
                  const Divider(
                    color: Color(0xFFCFCFCF),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
                        Container(
                          height: MediaQuery.of(context).size.height * .2,
                          decoration: BoxDecoration(
                            image: _selectedImage != null
                                ? DecorationImage(
                                    image: FileImage(_selectedImage!),
                                    fit: BoxFit.cover,
                                  )
                                : const DecorationImage(
                                    image: NetworkImage(
                                      'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            // Delete Icon
                            if (_selectedImage != null)
                              Container(
                                width: 48,
                                height: 48,
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        width: 1, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 28,
                                  ),
                                  onPressed: _deleteImage,
                                ),
                              ),
                            const SizedBox(width: 10),
                            // Add Icon
                            Container(
                              width: 48,
                              height: 48,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 1, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.add, size: 28),
                                onPressed: _pickImage,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        const Divider(color: Colors.black45),
                      ],
                    ),
                  ),
                  // const SizedBox(
                  //   height: 44,
                  // ),
                  const SizedBox(
                    height: 44,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
                          height: Get.height * .5,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned.fill(
                                child: _selectedVideo == null
                                    ? Center(
                                        child: GestureDetector(
                                          onTap: _pickVideo,
                                          child: const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                          Positioned.fill(
                                            child: AspectRatio(
                                              aspectRatio: _videoController!
                                                  .value.aspectRatio,
                                              child: VideoPlayer(
                                                  _videoController!),
                                            ),
                                          ),
                                          if (!_isPlaying)
                                            const Center(
                                              child: Icon(
                                                Icons.play_arrow,
                                                color: Colors.white,
                                                size: 50,
                                              ),
                                            ),
                                        ],
                                      ),
                              ),
                              if (_selectedVideo != null)
                                Positioned(
                                  top: 16,
                                  right: 16,
                                  child: GestureDetector(
                                    onTap: _deleteVideo,
                                    child: Container(
                                      width: 34,
                                      height: 34,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFF7F7F7),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(45),
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        if (_selectedVideo != null)
                          Center(
                            child: IconButton(
                              icon: Icon(
                                  _isPlaying ? Icons.pause : Icons.play_arrow),
                              color: Colors.white,
                              onPressed: _togglePlayPause,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 34,
                  ),
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
                  SizedBox(
                    height: Get.height * .048,
                  ),
                  Container(
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
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            height: 33,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  width: 1,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  color: Color(0xFF109B0E),
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Clear All',
                                  style: TextStyle(
                                    color: Color(0xFF109B0E),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            height: 33,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: ShapeDecoration(
                              color: const Color(
                                  0xFFFDCD54), // Yellow background color
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  width: 0.40,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  color: Color(0x19131A22),
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(30),
                              onTap: _savePost,
                              child: const Center(
                                child: Text(
                                  'Save Post',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: Get.height * .03,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
