import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:propertier/Utils/datetimeformatter.dart';
import 'package:propertier/Vendor/screens/drawer/orders/model/OrderModel.dart';
import 'package:propertier/Vendor/screens/drawer/orders/view/submit_work.dart';
import 'package:propertier/Vendor/screens/drawer/orders/viewmodel/OrderViewModel.dart';
import 'package:propertier/constant/colors.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  OrderViewModel controller = Get.put(OrderViewModel());

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
              child: TabBarView(controller: tabController, children: [
                Obx(()=>
            controller.orders.isEmpty ?
                Center(child: orderCard(OrderModel(id: 1, status: "pending",serviceLocation: "Lahore, Modal Town",totalAmount: "2500", selectedSubServices: [1])),)
                  :ListView.builder(
                    itemCount: controller.orders.length,
                    itemBuilder: (context, index){
                      OrderModel order = controller.orders[index];
                      return orderCard(order);
                    },
                  )
                ),
                Obx(()=>
                    ListView.builder(
                      itemCount: controller.orders.length,
                      itemBuilder: (context, index){
                        OrderModel order = controller.orders[index];
                        if(order.status == "completed"){
                          return orderCard(order);
                        }
                        return SizedBox();
                      },
                    )
                ),
                Obx(()=>
                    ListView.builder(
                      itemCount: controller.orders.length,
                      itemBuilder: (context, index){
                        OrderModel order = controller.orders[index];
                        if(order.status == "canceled"){
                          return orderCard(order);
                        }
                        return SizedBox();
                      },
                    )
                ),
                Obx(()=>
                    ListView.builder(
                      itemCount: controller.orders.length,
                      itemBuilder: (context, index){
                        OrderModel order = controller.orders[index];
                        if(order.status == "pending"){
                          return orderCard(order);
                        }
                        return SizedBox();
                      },
                    )
                ),
          ]))
        ],
      ),
    );
  }


  Widget orderCard(OrderModel order){
    Rxn selectedValue = Rxn();
    return Container(
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
            child: Row(
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
                        text: "${order.id?.toString()??""}",
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
                  "${formatDateToStandard(order.createdAt)}",
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
                    FutureBuilder(future: controller.getSubService(order.selectedSubServices?.isNotEmpty == true
                        ? order.selectedSubServices!.first.toString()
                        : ""),
                        builder: (context, subServiceSnap){
                          if(subServiceSnap.connectionState == ConnectionState.done){
                            return Text(
                              "${subServiceSnap.data?['title']??""}",
                              style: const TextStyle(
                                color: Color(0xE5131A22),
                                fontSize: 11.23,
                                fontWeight: FontWeight.w500,
                              ),
                            );
                          }
                          return SizedBox();
                        }
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
                          "Location",
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
                        text: "${order.totalAmount??""}",
                        style: const TextStyle(
                          color: Color(0xFF131A22),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: "Rs",
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
                Row(
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
                      '${order.serviceLocation??""}',
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
                            border: Border.all(color: Colors.amber, width: 1)),
                        child: Icon(
                          Icons.done,
                          size: 8,
                          color: Colors.amber,
                        )),
                    const SizedBox(width: 2),
                    Text(
                      "${order.status??""}",
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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: Obx(()=> DropdownButton<String>(
                    value: selectedValue.value,
                    hint: const Text('Update Order Status'),
                    isExpanded: true, // Ensures dropdown takes full width
                    items: <String>['Not Started', 'Started', 'Completed', 'Cancel']
                        .map((String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ))
                        .toList(),
                    onChanged: (String? newValue) {
                      selectedValue.value = newValue;
                    },
                    style: const TextStyle(fontSize: 14,color: AppColor.blackColor), // Customize text style
                  )),
                ),
              ),
              if(order.status == "pending")
              InkWell(
                onTap: (){
                  Get.to(SubmitWork(id: order.id.toString(),));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  alignment: Alignment.center,
                  child: Text("Submit Work",style: TextStyle(
                    color: AppColor.white,
                    fontSize: 12
                  ),),
                ),
              )
            ],
          )
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
