import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:propertier/Vendor/screens/dashboard/home/Controller/home_controller.dart';
import 'package:propertier/Vendor/screens/dashboard/home/view/detail_screen.dart';
import 'package:propertier/Vendor/screens/widgets/tabbar_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
    int selectedIndex = 0;
  bool isDrawerOpen = false;
  final WebSocketController webSocketController =
      Get.put(WebSocketController());

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
    tabController.addListener(() {
      setState(() {});
      isDrawerOpen = !isDrawerOpen;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Get.height * .08,
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
                const SizedBox(height: 5),
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
                    indicator: const BoxDecoration(),
                    tabs: [
                      TabBarItem(
                        title: 'Online',
                        isSelected: tabController.index == 0,
                        selectedColor: Colors.white,
                      ),
                      TabBarItem(
                        title: 'Offline',
                        isSelected: tabController.index == 1,
                        selectedColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        Expanded(
  child: TabBarView(
    controller: tabController,
    children: [
      Obx(() {
        var allOnlineBids = webSocketController.onlineBids; // Get all online bids
        return allOnlineBids.isNotEmpty
            ? ListView.builder(
                itemCount: allOnlineBids.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 60),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  var bid = allOnlineBids[index];

                  // Safely access the first selectedSubService if it's not empty
                  String subServiceTitle = bid.selectedSubServices.isNotEmpty
                      ? bid.selectedSubServices.first.title // Access the first sub-service title
                      : 'No sub-service'; // Default message if list is empty

                  return buildBidCard(
                    bid.customer.toString(),
                    subServiceTitle, // Use the sub-service title here
                    bid.status,
                    bid.createdAt,
                    bid.location,
                  );
                },
              )
            : noDataWidget();
      }),
      Obx(() {
        var allOfflineBids = webSocketController.offlineBids; // Get all offline bids
        return allOfflineBids.isNotEmpty
            ? ListView.builder(
                itemCount: allOfflineBids.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 60),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  var bid = allOfflineBids[index];

                  // Safely access the first selectedSubService if it's not empty
                  String subServiceTitle = bid.selectedSubServices.isNotEmpty
                      ? bid.selectedSubServices.first.title // Access the first sub-service title
                      : 'No sub-service'; // Default message if list is empty

                  return buildBidCard(
                    bid.customer.toString(),
                    subServiceTitle, // Use the sub-service title here
                    bid.status,
                    bid.createdAt,
                    bid.location,
                  );
                },
              )
            : noDataWidget();
      }),
    ],
  ),
),


        ],
      ),
    );
  }

  Widget buildBidCard(
    String customer,
    String parentServiceName,
    String status,
    String date,
    String location,
  ) {
    // Parse the date string (assuming it's in ISO8601 format) and format it to dd-mm-yyyy
    String formattedDate = '';
    try {
      DateTime parsedDate = DateTime.parse(date);
      formattedDate = DateFormat('dd-MM-yyyy').format(parsedDate);
    } catch (e) {
      formattedDate = 'Invalid date';
    }

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          padding: const EdgeInsets.only(left: 2, right: 2, bottom: 8),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 2, color: Color(0xFFF0F0F0)),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Column(
            children: [
              Container(
                width: Get.size.width,
                height: Get.height * .026,
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
                    Text('Customer ID: $customer',
                        style: const TextStyle(
                          color: Color(0xFF109B0E),
                          fontSize: 8,
                          fontWeight: FontWeight.w500,
                        )),
                    Text(formattedDate,
                        style: const TextStyle(
                          color: Color(0xB2131A22),
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: Get.size.width,
                height: Get.height * .074,
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 60,
                      height: double.infinity,
                      decoration: ShapeDecoration(
                        color: Colors.grey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            parentServiceName,
                            style: const TextStyle(
                              color: Color(0xFF131A22),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 5.62),
                          Text(' $location ',
                              style: const TextStyle(
                                color: Color(0xB2131A22),
                                fontSize: 8.99,
                                fontWeight: FontWeight.w500,
                              )),
                          const SizedBox(height: 5.62),
                          Text('Status: $status',
                              style: const TextStyle(
                                color: Color(0xFF109B0E),
                                fontSize: 8.99,
                                fontWeight: FontWeight.w400,
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Detail button
                        InkWell(
                          onTap: () {
                            Get.to(() => const DetailScreen());
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 3),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1, color: Color(0xFF109B0E)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Detail',
                                style: TextStyle(
                                  color: Color(0xFF109B0E),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        // Cancel button
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 3),
                          decoration: ShapeDecoration(
                            color: const Color(0xFFFFCE58),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: Color(0xFF131A22),
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget noDataWidget() {
    return const Center(
      child: Text(
        'No bids available.',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }
}
