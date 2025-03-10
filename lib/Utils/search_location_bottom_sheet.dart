import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/AppTextField/app_textfield.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../App/What are you searching/ViewModel/what_are_viewmodel.dart';

Future<dynamic> searchLocationBottomSheet({
  required RxList<Place> placesList,
  required BuildContext context,
  required TextEditingController searchController,
  required Function(String) onChange,
  required Function(String) onSelect,
}) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: context.getSize.height,
          width: context.getSize.width,
          child: Column(
            children: [
              getHeight(context, 0.01),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.getSize.width * 0.02),
                child: customTextField(
                    onChanged: onChange,
                    hintText: 'Search Address',
                    controller: searchController),
              ),
              getHeight(context, 0.010),
              Obx(
                () => ListView.builder(
                    shrinkWrap: true,
                    itemCount: placesList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          onSelect(placesList[index].description);
                        },
                        visualDensity: VisualDensity.adaptivePlatformDensity,
                        dense: true,
                        title: Text(placesList[index].description),
                      );
                    }),
              )
            ],
          ),
        );
      });
}


// import 'package:flutter/material.dart';
// import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
// import 'package:get/get.dart';
//
// Future<dynamic> searchLocationBottomSheet({
//   required RxList<String> placesList, // List of place names
//   required RxMap<String, GeoPoint> placesMap, // Map: Place Name -> GeoPoint
//   required BuildContext context,
//   required TextEditingController searchController,
//   required Function(String) onChange,
//   required Function(GeoPoint) onSelect, // Still need GeoPoint for selection
// }) {
//   return showModalBottomSheet(
//     context: context,
//     builder: (context) {
//       return SizedBox(
//         height: MediaQuery.of(context).size.height * 0.6,
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           children: [
//             const SizedBox(height: 10),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: TextField(
//                 controller: searchController,
//                 decoration: const InputDecoration(
//                   hintText: 'Search Address',
//                   prefixIcon: Icon(Icons.search),
//                   border: OutlineInputBorder(),
//                 ),
//                 onChanged: (value) async {
//                   if (value.isNotEmpty) {
//                     try {
//                       List<SearchInfo> results = await addressSuggestion(value);
//
//                       print("Full results from addressSuggestion: $results"); // Debugging
//
//                       placesList.clear();
//                       placesMap.clear();
//
//                       for (var place in results) {
//                         print("Raw Data -> Address: ${place.address}, Point: ${place.point}");
//
//                         if (place.address != null && place.point != null) {
//                           String addressString = place.address.toString(); // Ensure it's a String
//
//                           placesList.add(addressString);
//
//                           double lat = (place.point!.latitude as num).toDouble();
//                           double lng = (place.point!.longitude as num).toDouble();
//
//                           placesMap[addressString] = GeoPoint(latitude: lat, longitude: lng);
//                         }
//                       }
//                     } catch (e, stack) {
//                       print("Error in addressSuggestion: $e");
//                       print(stack);
//                     }
//
//                   } else {
//                     placesList.clear();
//                     placesMap.clear();
//                   }
//                 },
//               ),
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: Obx(
//                     () => ListView.builder(
//                   itemCount: placesList.length,
//                   itemBuilder: (context, index) {
//                     String placeName = placesList[index];
//
//                     return ListTile(
//                       onTap: () {
//                         if (placesMap.containsKey(placeName)) {
//                           onSelect(placesMap[placeName]!); // Pass GeoPoint
//                         }
//                         Navigator.pop(context);
//                       },
//                       title: Text(placeName), // Show place name
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }



