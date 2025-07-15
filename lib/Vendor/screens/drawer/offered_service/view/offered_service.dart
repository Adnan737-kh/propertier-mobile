import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfferedService extends StatefulWidget {
  const OfferedService({super.key});

  @override
  State<OfferedService> createState() => _OfferedServiceState();
}

class _OfferedServiceState extends State<OfferedService> {
  final TextEditingController _serviceNameController = TextEditingController();
  List<Service> _services = [];

  @override
  void initState() {
    super.initState();
    _loadServices();
  }

  Future<void> _loadServices() async {
    final prefs = await SharedPreferences.getInstance();
    final String? servicesString = prefs.getString('services');
    if (servicesString != null) {
      final List<dynamic> serviceList = json.decode(servicesString);
      setState(() {
        _services =
            serviceList.map((service) => Service.fromMap(service)).toList();
      });
    }
  }

  Future<void> _saveServices() async {
    final prefs = await SharedPreferences.getInstance();
    final String servicesString =
        json.encode(_services.map((service) => service.toMap()).toList());
    await prefs.setString('services', servicesString);
  }

  void _addService() {
    final String serviceName = _serviceNameController.text;
    if (serviceName.isNotEmpty) {
      setState(() {
        _services.add(Service(name: serviceName, isActive: false));
        _serviceNameController.clear();
      });
      _saveServices();
    }
  }

  void _toggleService(int index) {
    setState(() {
      _services[index].isActive = !_services[index].isActive;
    });
    _saveServices();
  }

  void _showAddServiceDialog() {
    TextEditingController serviceController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:  Text(
            context.local.add_your_service,
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: Color(0x99131A22),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          content: SizedBox(
            height: 34,
            child: TextFormField(
              controller: serviceController,
              cursorColor: Colors.amber,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.020,
                    horizontal: 8),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.10000000149011612),
                    )),
                hintText: context.local.enter_service_here,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.10000000149011612),
                    )),
                hintStyle: const TextStyle(
                  color: Color(0x66131A22),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                isDense: true,
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 35.59,
                    width: Get.width * .3,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFFF3333),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.23),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.clear,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _addService();
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 35.59,
                    width: Get.width * .3,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF109B0E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.23),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.done,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  List<String> serviceData = [
    'PVC pipes',
    'Copper pipes',
    'ABS pipes',
    'PEX pipes',
    'Copper pipes',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Get.height * .11,
            padding: const EdgeInsets.symmetric(horizontal: 4),
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
                  height: 34,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            )),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          context.local.offered_services,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 18),
                      child: InkWell(
                        onTap: () {
                          _showAddServiceDialog();
                        },
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * .6,
                  child: ListView.builder(
                    itemCount: serviceData.length,
                    itemBuilder: (context, index) {
                      // final service = _services[index];
                      return Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              serviceData[index],
                              style: const TextStyle(
                                color: Color(0x99131A22),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            trailing: CupertinoSwitch(
                              activeColor: const Color(0xFF109B0E),
                              value: true,
                              onChanged: (value) {},
                            ),
                          ),
                          const Divider()
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Service {
  String name;
  bool isActive;

  Service({required this.name, required this.isActive});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'isActive': isActive,
    };
  }

  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      name: map['name'],
      isActive: map['isActive'],
    );
  }
}
