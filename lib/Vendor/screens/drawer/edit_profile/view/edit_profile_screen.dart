import 'dart:io';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:propertier/Vendor/screens/dashboard/profile/controller/profile_controller.dart';
import 'package:propertier/Vendor/screens/dashboard/profile/model/profile_model.dart';
import 'package:propertier/Vendor/screens/widgets/primary_textfield.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late TextEditingController addressController;

  final ProfileController profileController = Get.put(ProfileController());
  late String vendorUserId;
  ProfileModel? originalProfile;
  bool _obscurePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  Country selectedCountry = Country(
    phoneCode: ProfileController().profile.value.phoneNumberCountryCode ?? "",
    countryCode: 'PK',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'Pakistan',
    example: 'Pakistan',
    displayName: 'Pakistan',
    displayNameNoCountryCode: 'PK',
    e164Key: '',
  );

  @override
  void initState() {
    profileController.loadProfile();
    super.initState();
    final box = GetStorage();
    vendorUserId = box.read('vendorUserId') ?? '';

    // print('Vendor User ID: $vendorUserId');

    originalProfile = profileController.profile.value.copyWith();
    addressController = TextEditingController(text: profileController.profile.value.address);
    phoneController = TextEditingController(text: profileController.profile.value.phoneNumber);
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> _updateProfilePicture() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      await profileController.updateProfilePicture(File(image.path), vendorUserId);
    }
  }

  Future<void> _updateCoverPicture() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileController.selectedCoverPhotoPath.value = image.path;

      final pngPath = await _convertToPng(image);
      await profileController.updateCoverPicture(vendorUserId, File(pngPath));

      profileController.profile.update((profile) {
        profile?.coverPhotoUrl = pngPath;
      });
    }
  }

  Future<String> _convertToPng(XFile pickedFile) async {
    final directory = await getTemporaryDirectory();
    final fileName = basename(pickedFile.path).split('.')[0];
    final newPath = join(directory.path, '$fileName.png');

    final bytes = await pickedFile.readAsBytes();
    final pngFile = File(newPath);
    await pngFile.writeAsBytes(bytes);

    return newPath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(children: [
              Stack(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: Get.height * .16,
                    width: Get.size.width,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(0.05000000074505806),
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x19000000),
                          blurRadius: 10,
                          offset: Offset(0, 1),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                      child: InkWell(
                        onTap: () {
                          _updateCoverPicture();
                        },
                        child: Obx(() {
                          return profileController
                                  .selectedCoverPhotoPath.isNotEmpty
                              ? Image.file(
                                  File(profileController
                                      .selectedCoverPhotoPath.value),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 200,
                                )
                              : Image.network(
                                  profileController.profile.value.coverPhotoUrl ??
                                      'https://images.unsplash.com/photo-1719054415148-b83895be5157?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90b3MtZmVlZHw0NHx8fGVufDB8fHx8fA%3D%3D',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 200,
                                );
                        }),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 22,
                      left: 6,
                      right: 8,
                      child: Row(children: [
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            )),
                        const Text(
                          'Edit Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ])),
                  Positioned(
                    top: 89,
                    child: Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            _updateProfilePicture();
                          },
                          child: Container(
                            width: 95,
                            height: 95,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: NetworkImage(profileController
                                        .profile.value.profilePictureUrl ??
                                    "https://images.unsplash.com/photo-1719054415148-b83895be5157?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90b3MtZmVlZHw0NHx8fGVufDB8fHx8fA%3D%3D"),
                                fit: BoxFit.cover,
                              ),
                              shape: const OvalBorder(
                                side: BorderSide(width: 5, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            profileController.profile.value.followers.toString(),
                            style: const TextStyle(
                              color: Color(0xFFFDCD54),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Followers',
                            style: TextStyle(
                              color: Color(0x99131A22),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 145),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            profileController.profile.value.likes.toString(),
                            style: const TextStyle(
                              color: Color(0xFFFDCD54),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Likes',
                            style: TextStyle(
                              color: Color(0x99131A22),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        profileController.profile.value.name.toString(),
                        style: const TextStyle(
                          color: Color(0xFF131A22),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        (profileController.profile.value.drivingLicenseVerified??false) == true? "Verified": "Un-verified",
                        style:  TextStyle(
                          color: (profileController.profile.value.drivingLicenseVerified??false) == true? Colors.green: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  // RatingBar.builder(
                  //     initialRating:
                  // profileController.profile.value!.name?.toDouble(),
                  // minRating: 0,
                  // direction: Axis.horizontal,
                  // allowHalfRating: true,
                  // itemCount: 5,
                  // itemSize: 20,
                  // itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                  // itemBuilder: (context, _) => const Icon(
                  //       Icons.star,
                  //       color: Colors.amber,
                  //       size: 26,
                  //     ),
                  // onRatingUpdate: (rating) async {}),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PrimaryTextField(
                      controller: TextEditingController(
                          text: profileController.profile.value.name),
                      headertext: 'Full Name',
                      text: 'your name',
                      suffixIcon: const Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                      onChanged: (value) =>
                          profileController.profile.value.name = value,
                    ),
                    const SizedBox(
                      height: 19,
                    ),
                    const Text(
                      'Phone Number',
                      style: TextStyle(
                        color: Color(0xFF131A22),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    TextFormField(
                      cursorColor: Colors.black,
                      controller: TextEditingController(
                          text: profileController.profile.value.phoneNumber),
                      onChanged: (value) =>
                          profileController.profile.value.phoneNumber = value,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.width * 0.029,
                          ),
                          labelStyle: const TextStyle(
                            fontSize: 16,
                          ),
                          hintText: 'your number',
                          hintStyle: const TextStyle(
                            color: Color(0xB2131A22),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          prefixIcon: Container(
                            padding: const EdgeInsets.only(
                              top: 11,
                              right: 9,
                              left: 2,
                            ),
                            child: InkWell(
                              onTap: () {
                                showCountryPicker(
                                  context: context,
                                  countryListTheme: CountryListThemeData(
                                    bottomSheetHeight: Get.height * .5,
                                    inputDecoration: InputDecoration(
                                      labelText: 'Search',
                                      hintText: 'Start typing to search',
                                      prefixIcon: const Icon(Icons.search),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: const Color(0xFF8C98A8)
                                              .withOpacity(0.2),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onSelect: (value) {
                                    setState(() {
                                      selectedCountry = value;
                                    });
                                  },
                                );
                              },
                              child: Text(
                                "${selectedCountry.flagEmoji} ${selectedCountry.phoneCode}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          suffixIcon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          )),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(
                      height: 19,
                    ),
                    PrimaryTextField(
                      controller: passwordController,
                      headertext: 'Password',
                      text: '24643456',
                      // obsecure: _obscurePassword,
                      suffixIcon: const Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 19),
                    PrimaryTextField(
                      controller: addressController,
                      headertext: 'Address',
                      text: 'Bahria town phase 7 ,lahore',
                      suffixIcon: const Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                      onChanged: (value) =>
                          profileController.profile.value.address = value,
                    ),
                    const SizedBox(height: 19),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Driving License Front",
                          style: TextStyle(
                            color: Color(0xFF131A22),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        InkWell(
                          onTap: ()async{
                            final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                            if (image != null) {
                              profileController.updateDrivingLicense(File(image.path), null, vendorUserId);
                            }
                          },
                          child: (profileController.profile.value.drivingLicenseFrontUrl??"") == ""?
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            width: Get.width,
                            height: 100,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            alignment: Alignment.center,
                            child: const Text("Upload Image"),
                          ): Container(
                              margin:const  EdgeInsets.symmetric(vertical: 10),
                              height: 150,
                              child: Center(child: Image.network(profileController.profile.value.drivingLicenseFrontUrl!))),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Driving License Back",
                          style: TextStyle(
                            color: Color(0xFF131A22),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        InkWell(
                          onTap: ()async{
                            final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                            if (image != null) {
                              profileController.updateDrivingLicense(null,File(image.path), vendorUserId);
                            }
                          },
                          child: (profileController.profile.value.drivingLicenseBackUrl??"") == ""?
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            width: Get.width,
                            height: 100,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            alignment: Alignment.center,
                            child:const  Text("Upload Image"),
                          ): Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            height: 150,
                              child: Center(child: Image.network(profileController.profile.value.drivingLicenseBackUrl!))),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 44,
                    ),
                    InkWell(
                      onTap: () async {
                        final currentProfile = profileController.profile.value;

                        // Check if there are any changes to be updated
                        if (currentProfile.name == originalProfile?.name &&
                            currentProfile.phoneNumber ==
                                originalProfile?.phoneNumber &&
                            currentProfile.address ==
                                originalProfile?.address &&
                            currentProfile.email == originalProfile?.email) {
                          Get.snackbar('Info', 'Nothing to update');
                          return;
                        }

                        // Call the update function correctly
                        await profileController.updateUserProfile(
                          vendorUserId,
                          currentProfile, // Pass the profile model
                          profileController, // Pass the controller directly, no casting
                          context, // Pass the build context directly, no casting
                        );
                      },
                      child: Container(
                        width: Get.size.width,
                        height: Get.height * .071,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFDCD54),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Save',
                            style: TextStyle(
                              color: Color(0xFF131A22),
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
