import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:propertier/Vendor/screens/dashboard/earnings/Controller/earning_controller.dart';
import 'package:propertier/extensions/localization_extension.dart';
import '../../../widgets/tabbar_item.dart';

class EarningScreen extends StatefulWidget {
  const EarningScreen({super.key});

  @override
  State<EarningScreen> createState() => _EarningScreenState();
}

class _EarningScreenState extends State<EarningScreen>
    with SingleTickerProviderStateMixin {
  final EarningController earningController = Get.put(EarningController());
  late TabController tabController;
  late String vendorUserId;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
    tabController.addListener(() {
      setState(() {});
    });

    final box = GetStorage();
    vendorUserId = box.read('vendorUserId') ?? '';
    if (vendorUserId.isNotEmpty) {
      earningController.fetchEarningData(vendorUserId);
    } else {
      Get.snackbar('Error', 'Vendor ID is not available');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF131A22),
          leading: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          actions: [
            InkWell(
              onTap: () {},
              child: SvgPicture.asset(
                'assets/wallet.svg',
                height: 24,
              ),
            ),
            const SizedBox(
              width: 14,
            )
          ],
        ),
        body: Obx(() {
          if (earningController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final earnings = earningController.earning.value;

          return Column(
            children: [
              Container(
                height: Get.height * .24,
                padding: const EdgeInsets.symmetric(horizontal: 18),
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
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      height: Get.height * .072,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            color: Colors.black.withOpacity(0.1),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'This Month',
                                style: TextStyle(
                                  color: Color(0x99131A22),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${earnings.monthlyEarning}',
                                style: const TextStyle(
                                  color: Color(0xFF131A22),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Linked Account',
                                style: TextStyle(
                                  color: Color(0x99131A22),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 2),
                              Row(
                                children: [
                                  Icon(Icons.wallet),
                                  SizedBox(width: 2),
                                  Text(
                                    '375623947348734', // Hardcoded for now
                                    style: TextStyle(
                                      color: Color(0xFF131A22),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Total Earning',
                              style: TextStyle(
                                color: Color(0xFFFDCD54),
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${earnings.totalEarnings}',
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 2,
                          height: 33,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              context.local.width_draw,
                              style: const TextStyle(
                                color: Color(0xFFFDCD54),
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${earnings.withdrawals}',
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 2,
                          height: 33,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Deductions',
                              style: TextStyle(
                                color: Color(0xFFFDCD54),
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${earnings.deductions}',
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    Container(
                      height: Get.height * .05,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      child: TabBar(
                          dividerColor: Colors.transparent,
                          labelPadding: EdgeInsets.zero,
                          controller: tabController,
                          indicator:
                              const BoxDecoration(), // Remove the underline
                          tabs: [
                            TabBarItem(
                              title: context.local.completed,
                              isSelected: tabController.index == 0,
                              selectedColor: Colors.white,
                            ),
                            TabBarItem(
                              title: context.local.cancelled,
                              isSelected: tabController.index == 1,
                              selectedColor: Colors.white,
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Expanded(
                  child: TabBarView(controller: tabController, children: const [
                EarningTab(
                  work: 'Automatic Car Washing',
                  amount: '30000',
                  location: 'Bahria town phase 3',
                  status: 'Completed',
                  currency: 'PKR',
                ),
                EarningTab(
                    work: 'Plumbing work',
                    amount: '-300',
                    location: 'Bahria town phase 6',
                    currency: 'PKR',
                    status: 'Cancelled'),
              ]))
            ],
          );
        }));
  }
}

class EarningTab extends StatelessWidget {
  final String work;
  final String amount;
  final String currency;
  final String location;
  final String status;
  const EarningTab({
    super.key,
    required this.work,
    required this.amount,
    required this.location,
    required this.status,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 8,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          // width: Get,
          // height: 104,
          margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          padding: const EdgeInsets.only(left: 2, right: 2, bottom: 8),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 2, color: Color(0xFFF0F0F0)),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 24,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                decoration: const ShapeDecoration(
                  color: Color(0xFFF0F0F0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: context.local.order_id,
                            style: const TextStyle(
                              color: Color(0xFF109B0E),
                              fontSize: 8,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const TextSpan(
                            text: ' ',
                            style: TextStyle(
                              color: Color(0xB2131A22),
                              fontSize: 8,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const TextSpan(
                            text: '8347438893',
                            style: TextStyle(
                              color: Color(0xB2131A22),
                              fontSize: 8,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      '2-10-2024',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xB2131A22),
                        fontSize: 8,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          work,
                          style: const TextStyle(
                            color: Color(0xE5131A22),
                            fontSize: 11.23,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: const Color(0xFF5A5A5E),
                                      width: 1)),
                              child: const Icon(
                                Icons.circle,
                                color: Color(0xFF5A5A5E),
                                size: 10,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              location,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: Color(0xFF596068),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "$amount ",
                            style: const TextStyle(
                              color: Color(0xFF131A22),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: currency,
                            style: const TextStyle(
                              color: Color(0xFF109B0E),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
              RotatedBox(quarterTurns: -1, child: Text('.' * 4, maxLines: 1)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: Color(0xFFE4A951),
                          size: 17,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          'Kachari Chowk Main Rawalpindi ',
                          style: TextStyle(
                            color: Color(0xFF596068),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: const Color(0xFFE4A951), width: 1)),
                            child: const Icon(
                              Icons.done,
                              color: Colors.amber,
                              size: 8,
                            )),
                        const SizedBox(width: 2),
                        Text(
                          status,
                          style: const TextStyle(
                            color: Color(0x7F131A22),
                            fontSize: 8,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 1),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
