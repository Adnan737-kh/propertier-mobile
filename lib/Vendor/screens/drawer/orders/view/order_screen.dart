import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF131A22),
        iconTheme: const IconThemeData(color: Colors.white),

        // title: ,
        title: const Text(
          'Orders',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: Get.height * .05,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const ShapeDecoration(
              color: Color(0xFF131A22),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),
            child: TabBar(
                dividerColor: Colors.transparent,
                labelPadding: EdgeInsets.zero,
                controller: tabController,
             
                tabs: [
                  Text(
                    'All',
                    style: TextStyle(
                      color: tabController.index == 0
                          ? const Color(0xFFFFCE58)
                          : Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Completed',
                    style: TextStyle(
                      color: tabController.index == 1
                          ? const Color(0xFFFFCE58)
                          : Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Cancelled',
                    style: TextStyle(
                      // color: Colors.white,
                      color: tabController.index == 2
                          ? const Color(0xFFFFCE58)
                          : Colors.white,

                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Pending',
                    style: TextStyle(
                      // color: Colors.white,
                      color: tabController.index == 3
                          ? const Color(0xFFFFCE58)
                          : Colors.white,

                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ]),
          ),
          const SizedBox(
            height: 14,
          ),
          Expanded(
              child: TabBarView(controller: tabController, children: const [
            EarningTab(
              work: 'Automatic Car Washing',
              amount: '20000',
              location: 'Bahria town phase 3',
              status: 'cancelled',
              currency: 'PKR',
              iconData: Icon(
                Icons.done,
                size: 8,
                color: Colors.amber,
              ),
              color: Colors.amber,
            ),
            EarningTab(
              work: 'Automatic Car Washing',
              amount: '36000',
              location: 'Bahria town phase 3',
              status: 'Completed',
              currency: 'PKR',
              iconData: Icon(
                Icons.done,
                size: 8,
                color: Colors.amber,
              ),
              color: Colors.amber,
            ),
            EarningTab(
              work: 'Automatic Car Washing',
              amount: '-400',
              location: 'Bahria town phase 3',
              status: 'Cancelled',
              currency: 'PKR',
              iconData: Icon(
                Icons.clear,
                size: 8,
                color: Colors.red,
              ),
              color: Colors.red,
            ),
            EarningTab(
                work: 'Plumbing work',
                amount: '-300',
                location: 'Bahria town phase 6',
                currency: 'PKR',
                iconData: Icon(
                  Icons.refresh,
                  size: 8,
                  color: Colors.blue,
                ),
                color: Colors.blue,
                status: 'Pending'),
          ]))
        ],
      ),
    );
  }
}

class EarningTab extends StatelessWidget {
  final String work;
  final String amount;
  final String currency;
  final String location;
  final String status;
  final Color color;

  final Widget iconData;
  const EarningTab({
    super.key,
    required this.work,
    required this.amount,
    required this.location,
    required this.status,
    required this.currency,
    required this.iconData,
    required this.color,
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
          margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Order ID:',
                            style: TextStyle(
                              color: Color(0xFF109B0E),
                              fontSize: 8,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: ' ',
                            style: TextStyle(
                              color: Color(0xB2131A22),
                              fontSize: 8,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
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
                    SizedBox(width: 5),
                    Text(
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
                                border: Border.all(color: color, width: 1)),
                            child: iconData),
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
