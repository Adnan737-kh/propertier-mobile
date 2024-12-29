import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Services/Model/FixedServicesModel.dart';
import 'package:propertier/App/Services/Model/services_model.dart';
import 'package:propertier/App/Services/Service/ServicesCore.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/localization_extension.dart';
import '../../../Vendor/screens/dashboard/Posts/add_post/Model/title_model.dart';
import '../../../Vendor/screens/dashboard/Posts/select_category/View/select_category.dart';
import '../Model/ServiceDashboardModel.dart';
import 'package:propertier/Vendor/helpers/api_service.dart';

class ServicesViewModel extends GetxController {

 @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    GetServicesDashboard();
  }
  ServicesCore servicesCore = ServicesCore();

 TextEditingController searchCOntroller = TextEditingController();
 List<ServicesModel> servciesList = <ServicesModel>[
   ServicesModel(title: Get.context!.local.plumber, icon: Constant.plumber),
   ServicesModel(
       title: Get.context!.local.electrician, icon: Constant.electrician),
   ServicesModel(
       title: Get.context!.local.acTechnician, icon: Constant.acMechanic),
   ServicesModel(title: Get.context!.local.gardener, icon: Constant.gardner),
   ServicesModel(
       title: Get.context!.local.carpanter, icon: Constant.carpanter),
   ServicesModel(title: Get.context!.local.painter, icon: Constant.painter),
 ];

 List<ServicesModel> topSellingList = <ServicesModel>[
   ServicesModel(
       title: 'Architecture Designer', icon: Constant.architactureDesigner),
   ServicesModel(title: 'Handmade 3D Sketches', icon: Constant.sketches),
   ServicesModel(
       title: 'Graphic & Logo Designer', icon: Constant.logoDesigner),
 ];

 Future<List<FixedServicesModel>> getFixedServices(BuildContext context)async{
   return servicesCore.getFixedServices(context: context);
 }
 Future<List<ParentServicesModel>> getAllParentServices(BuildContext context)async{
   return servicesCore.getAllParentServices(context: context);
 }
 Future<ServicePaginationModel?> getPaginationServices(BuildContext context)async{
   return await servicesCore.ServicesPagination(context: context);
 }

 Rxn<ServiceDashboardModel> serviceDashboardModel = Rxn<ServiceDashboardModel>();

 Future GetServicesDashboard()async{
   serviceDashboardModel.value = await servicesCore.ServicesDashboard(context: Get.context!);
 }



 final ApiService apiService = ApiService();
 var isLoading = false.obs;
 var parentServicesMap = <String, String>{}.obs;
 String? selectedParentServiceId;
 var titles = <TitleModel>[].obs;
 var errorMessage = RxnString();
 String? selectedCategory;
 String? parentId;

 Future openSelectCategoryScreen(BuildContext context) async {
   showDialog(
     context: context,
     barrierDismissible: false,
     builder: (context) => Center(child: CircularProgressIndicator()),
   );

   await fetchParentServices();

   if (Navigator.of(context).canPop()) {
     Navigator.of(context).pop();
   }
   print('Fetched Parent Services Map: ${parentServicesMap}');

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
             await fetchTitlesForParentService(category);
             print('Fetched Titles for $category:');

             titles.forEach((titleModel) {
               print('Title: ${titleModel.title}, ID: ${titleModel.id}');
             });

               parentId =selectedParentServiceId;
               selectedCategory = category;

             if (Navigator.of(context).canPop()) {
               Navigator.of(context).pop();
             }
           }
         },
         parentServices: parentServicesMap.keys.toList(),
       );
     },
   );
 }


 // Fetch Parent Services
 Future<void> fetchParentServices() async {
   try {
     isLoading.value = true;
     final data = await apiService.fetchParentServices();  // Use ApiService for API call
     Map<String, String> servicesMap = {};
     for (var item in data) {
       servicesMap[item['title']??''] = item['id'].toString();
     }

     parentServicesMap.value = servicesMap;
     errorMessage.value = null;
   } catch (e) {
     errorMessage.value = 'An error occurred: $e';
   } finally {
     isLoading.value = false;
     update();
   }
 }

 // Fetch Titles for a Specific Parent Service
 Future<void> fetchTitlesForParentService(String parentServiceName) async {
   try {
     isLoading.value = true;
     final titlesList = await apiService.fetchTitlesForParentService(parentServiceName);  // Use ApiService

     titles.value = titlesList;
     selectedParentServiceId = parentServicesMap[parentServiceName] ?? '';
     print('Fetched Titles for $parentServiceName: $titlesList');
     print('Selected Parent Service ID: ${selectedParentServiceId}');
     errorMessage.value = null;
   } catch (e) {
     errorMessage.value = 'An error occurred: $e';
   } finally {
     isLoading.value = false;
     update();
   }
 }
}
