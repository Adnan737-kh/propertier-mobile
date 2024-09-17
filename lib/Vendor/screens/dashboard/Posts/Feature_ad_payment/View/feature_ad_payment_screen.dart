import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/Vendor/screens/dashboard/Posts/Feature_ad_payment/Controller/feature_ad_controller.dart';
import 'package:propertier/Vendor/screens/dashboard/Posts/Feature_ad_payment/Model/feature_ad_model.dart';

import '../../../../widgets/round_checkbox.dart';

class FeatureAdPaymentScreen extends StatefulWidget {
  const FeatureAdPaymentScreen({super.key});

  @override
  State<FeatureAdPaymentScreen> createState() => _FeatureAdPaymentScreenState();
}

class _FeatureAdPaymentScreenState extends State<FeatureAdPaymentScreen> {
  bool _isChecked = true;
  bool isWeek = false;
  bool isFifteen = false;
  bool isMonth = false;

  String featureDuration = '';
  String price = '';
  String status = 'inactive';

  final FeaturePackageController _controller = FeaturePackageController();

  void updateFeatureDetails() {
    if (isWeek) {
      featureDuration = formatFeatureDuration(const Duration(days: 7));
      price = '500 PKR';
      status = 'active';
    } else if (isFifteen) {
      featureDuration = formatFeatureDuration(const Duration(days: 15));
      price = '1000 PKR';
      status = 'active';
    } else if (isMonth) {
      featureDuration = formatFeatureDuration(const Duration(days: 30));
      price = '1500 PKR';
      status = 'active';
    } else {
      featureDuration = '';
      price = '';
      status = 'inactive';
    }
  }

  String formatFeatureDuration(Duration duration) {
    int days = duration.inDays;
    int hours = duration.inHours.remainder(24);
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    // Format the duration as [DD] [HH:[MM:]]ss[.uuuuuu]
    String formattedDuration = '${days.toString().padLeft(2, '0')} '
        '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';

    return formattedDuration;
  }

  void submitFeaturePackage() {
    final featurePackage = Featureadd(
      featureDuration: featureDuration,
      price: int.parse(price.replaceAll(' PKR', '')), // Convert price to int
      status: status,
      title: 'pkg 15',
      type: 'profile',
      image: null,
    );

    _controller.submitFeaturePackage(featurePackage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Feature Add',
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Color(0xFF1F0101),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 14,
            ),
            const Text(
              'Payment Method',
              style: TextStyle(
                color: Color(0xCC292929),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 83,
                  height: 86,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 1, color: Color(0xFF41A2FB)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/easy.png'),
                      const SizedBox(height: 4.60),
                      const Text(
                        'easypaisa',
                        style: TextStyle(
                          color: Color(0xFF41A1FB),
                          fontSize: 10.35,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 25),
                Container(
                  width: 83.33,
                  height: 87.36,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 2, color: Color(0xFFF3F3F3)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/jazz.png'),
                      const SizedBox(height: 4.75),
                      const Text(
                        'Jazz Cash',
                        style: TextStyle(
                          color: Color(0xFF737B8B),
                          fontSize: 10.68,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 25),
                Container(
                  width: 83.33,
                  height: 87.36,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 2, color: Color(0xFFF3F3F3)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.account_balance),
                      SizedBox(height: 4.75),
                      Text(
                        'Bank',
                        style: TextStyle(
                          color: Color(0xFF737B8B),
                          fontSize: 10.68,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Divider(
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      side: const BorderSide(color: Colors.black38),
                      activeColor: Colors.amber,
                      value: isWeek,
                      onChanged: (value) {
                        setState(() {
                          isWeek = value!;
                          isFifteen = isMonth = false; // Uncheck other options
                          updateFeatureDetails();
                        });
                      },
                    ),
                    const Text(
                      '7 Days',
                      style: TextStyle(
                        color: Color(0xFF737B8B),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const Text(
                  '500 PKR',
                  style: TextStyle(
                    color: Color(0xFF41A2FB),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(1),
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: const Color(0xFFFFCE58), width: 1)),
                  child: const Icon(
                    Icons.circle,
                    color: Color(0xFFFFCE58),
                    size: 10,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Propertier property evaluation and\n verification.',
                  style: TextStyle(
                    color: Color(0xFF737B8B),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 22,
            ),
            Divider(
              color: Colors.grey.shade300,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      side: const BorderSide(color: Colors.black38),
                      activeColor: Colors.amber,
                      value: isFifteen,
                      onChanged: (value) {
                        setState(() {
                          isFifteen = value!;
                          isWeek = isMonth = false;
                          updateFeatureDetails();
                        });
                      },
                    ),
                    const Text(
                      '15 Days',
                      style: TextStyle(
                        color: Color(0xFF737B8B),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const Text(
                  '1000 PKR',
                  style: TextStyle(
                    color: Color(0xFF41A2FB),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.grey.shade300,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      side: const BorderSide(color: Colors.black38),
                      activeColor: Colors.amber,
                      value: isMonth,
                      onChanged: (value) {
                        setState(() {
                          isMonth = value!;
                          isWeek = isFifteen = false; // Uncheck other options
                          updateFeatureDetails();
                        });
                      },
                    ),
                    const Text(
                      '1 month',
                      style: TextStyle(
                        color: Color(0xFF737B8B),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const Text(
                  '1500 PKR',
                  style: TextStyle(
                    color: Color(0xFF41A2FB),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 9),
            // Display the selected details
            // Text(
            //   'Selected Duration: $featureDuration\nPrice: $price\nStatus: $status',
            //   style: const TextStyle(
            //     color: Color(0xFF292929),
            //     fontSize: 14,
            //     fontWeight: FontWeight.w600,
            //   ),
            // ),
            Divider(
              color: Colors.grey.shade300,
            ),
            const SizedBox(
              height: 22,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Get your Add Featured:',
                  style: TextStyle(
                    color: Color(0xCC292929),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RoundCheckbox(
                      value: _isChecked,
                      onChanged: (bool newValue) {
                        setState(() {
                          _isChecked = newValue;
                        });
                      },
                      activeColor: Colors.blue,
                      checkColor: Colors.white,
                      inactiveColor: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Reach up to 10x more buyers.',
                      style: TextStyle(
                        color: Color(0xFF737B8B),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RoundCheckbox(
                      value: _isChecked,
                      onChanged: (bool newValue) {
                        setState(() {
                          _isChecked = newValue;
                        });
                      },
                      activeColor: Colors.blue,
                      checkColor: Colors.white,
                      inactiveColor: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Show your Ad in top position.',
                      style: TextStyle(
                        color: Color(0xFF737B8B),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RoundCheckbox(
                      value: _isChecked,
                      onChanged: (bool newValue) {
                        setState(() {
                          _isChecked = newValue;
                        });
                      },
                      activeColor: Colors.blue,
                      checkColor: Colors.white,
                      inactiveColor: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Get noticed with a Feature Ad tag.',
                      style: TextStyle(
                        color: Color(0xFF737B8B),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Divider(
                  color: Colors.grey.shade300,
                ),
              ],
            ),
            const SizedBox(
              height: 26,
            ),
            Container(
              height: 39,
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: ShapeDecoration(
                color: const Color(0xFFFFCE58),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  submitFeaturePackage();
                  Get.back();
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Submit',
                      style: TextStyle(
                        color: Color(0xFF292929),
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
