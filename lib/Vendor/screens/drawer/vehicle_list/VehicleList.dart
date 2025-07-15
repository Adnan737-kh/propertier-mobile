import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:propertier/Vendor/screens/drawer/vehicle_list/AddVehicle.dart';
import 'package:propertier/Vendor/screens/drawer/vehicle_list/model/VehicleModel.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/localization_extension.dart';

import '../../dashboard/profile/controller/profile_controller.dart';
import 'component/components.dart';


class VehicleList extends StatefulWidget {
  const VehicleList({super.key});

  @override
  State<VehicleList> createState() => _VehicleListState();
}

class _VehicleListState extends State<VehicleList> {

  final ProfileController profileController = Get.put(ProfileController());
  late String vendorUserId;

  @override
  void initState() {
    profileController.loadProfile();
    super.initState();
    final box = GetStorage();
    vendorUserId = box.read('vendorUserId') ?? '';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            width: Get.size.width,
            height: Get.height * .124,
            padding: const EdgeInsets.only(top: 38, left: 8),
            decoration: ShapeDecoration(
              color: const Color(0xFF131A22),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: Colors.black.withOpacity(0.05),
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
            child: Center(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 4),
                   Text(
                    context.local.my_vehicles,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Expanded(
            child: FutureBuilder(future: profileController.fetchMyVehicles(vendorUserId),
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if(snapshot.connectionState == ConnectionState.done){
                    List<VehicleModel> vehicles = snapshot.data??[];
                    return ListView.builder(
                      itemCount: vehicles.length,
                        itemBuilder: (context, index){
                          VehicleModel vehicleModel = vehicles[index];
                          return CarCard(
                            vehicle: vehicleModel,
                          )
                          ;
                        }
                    );
                  }
                  return  Center(
                    child: Text(context.local.no_vehicle_found),
                  );
                }
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.forGroundColor,
          onPressed: (){
            Get.to(const AddVehicle());
          },
        child: const Icon(Icons.add),
      ),
    );
  }
}
