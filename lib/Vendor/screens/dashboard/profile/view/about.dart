import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/Vendor/screens/dashboard/profile/controller/profile_controller.dart';
import 'package:propertier/Vendor/screens/dashboard/profile/model/profile_model.dart';
import 'package:propertier/extensions/localization_extension.dart';

class AboutContent extends StatefulWidget {
  final String vendorUserId;
  final ProfileModel profileModel;
  final String aboutText;
  final Future<void> Function(
      String, ProfileModel, ProfileController, BuildContext) updateUserProfile;

  const AboutContent({
    super.key,
    required this.vendorUserId,
    required this.profileModel,
    required this.aboutText,
    required this.updateUserProfile,
  });

  @override
  _AboutContentState createState() => _AboutContentState();
}

class _AboutContentState extends State<AboutContent> {
  late TextEditingController _aboutController;

  @override
  void initState() {
    super.initState();
    _aboutController = TextEditingController(text: widget.aboutText);
  }

  @override
  void dispose() {
    _aboutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Close button
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              const SizedBox(height: 10),

              TextField(
                controller: _aboutController,
                decoration: InputDecoration(
                  labelText: context.local.enter_about_information,
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                ),
                minLines: 3,
                maxLines: 5,
              ),
              const SizedBox(height: 20),

              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () async {
                    await widget.updateUserProfile(
                      widget.vendorUserId,
                      widget.profileModel
                          .copyWith(about: _aboutController.text),
                      Get.find<ProfileController>(),
                      context,
                    );
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFCE58),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                  child:  Text(
                    context.local.save,
                    style: const TextStyle(fontSize: 16, color: Color(0xE5131A22)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
