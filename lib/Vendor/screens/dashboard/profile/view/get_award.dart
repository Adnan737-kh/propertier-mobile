// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../controllers/award_controller.dart';
// import '../../../models/award_model.dart';

// class GetAward extends StatefulWidget {
//   const GetAward({super.key});

//   @override
//   State<GetAward> createState() => _GetAwardState();
// }

// class _GetAwardState extends State<GetAward> {
//   final AwardController awardController = Get.put(AwardController());

//   @override
//   void setState(VoidCallback fn) {
//     awardController.getAwards();
//     super.setState(fn);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//       appBar: AppBar(
//         title: Text('Awards'),
//       ),

//       body:
//          SingleChildScrollView(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 14),
//                           child: Column(
//                             children: [
//                               const SizedBox(
//                                 height: 12,
//                               ),
//                               awardController.isLoading.value
//                                   ? const CircularProgressIndicator()
//                                   : Container(
//                                       height: Get.height * .3,
//                                       child: GridView.builder(
//                                         padding: EdgeInsets.zero,
//                                         itemCount:
//                                             awardController.allAwards.length,
//                                         shrinkWrap: true,
//                                         gridDelegate:
//                                             SliverGridDelegateWithFixedCrossAxisCount(
//                                                 crossAxisSpacing: 12,
//                                                 mainAxisExtent:
//                                                     Get.height * .29,
//                                                 crossAxisCount: 2),
//                                         itemBuilder: (context, index) {
//                                           final award =
//                                               awardController.allAwards[index];

//                                           return Container(
//                                             decoration: ShapeDecoration(
//                                               image: DecorationImage(
//                                                 image: NetworkImage(
//                                                     award.imageUrl.toString()),
//                                                 fit: BoxFit.cover,
//                                               ),
//                                               shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(5)),
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                     ),
//                               const SizedBox(
//                                 height: 12,
//                               ),
//                               awardController.image == null
//                                   ? const SizedBox()
//                                   : Column(
//                                     children: [
//                                       Image.file(
//                                           height: Get.height * .24,
//                                           width: Get.width*.8,
//                                           File(awardController.image!.path)),

//                                           ElevatedButton(onPressed: () {

//                                             AwardModel awardModel=AwardModel(
//                                               imageUrl: awardController.image.toString(),
//                                               createdAt: ,
//                                               id: ,
//                                               updatedAt: ,
//                                               vendor: 
                                            
//                                             ) ;
//                                             awardController.addService(awardModel);
//                                           }, child: Text('Add'))
//                                     ],
//                                   ),
//                               const SizedBox(
//                                 height: 18,
//                               ),
//                               Container(
//                                 height: 34,
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 12, vertical: 4),
//                                 decoration: ShapeDecoration(
//                                   color: const Color(0x0C109B0E),
//                                   shape: RoundedRectangleBorder(
//                                     side: const BorderSide(
//                                         width: 1, color: Color(0xFF109B0E)),
//                                     borderRadius: BorderRadius.circular(2),
//                                   ),
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Container(
//                                       width: 22,
//                                       height: 22,
//                                       clipBehavior: Clip.antiAlias,
//                                       decoration: const BoxDecoration(),
//                                       child: const Icon(
//                                         Icons.add,
//                                         color: Colors.green,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 9),
//                                     InkWell(
//                                       onTap: () {
//                                         awardController.pickImage();
//                                       },
//                                       child: const Text(
//                                         'Add Award',
//                                         style: TextStyle(
//                                           color: Color(0xFF109B0E),
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 12,
//                               ),
//                               const Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     'Uploaded Posts',
//                                     style: TextStyle(
//                                       color: Color(0xFF131A22),
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                   SizedBox(width: 10),
//                                   Opacity(
//                                     opacity: 0.60,
//                                     child: Text(
//                                       'View All',
//                                       style: TextStyle(
//                                         color: Color(0xFF109B0E),
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(
//                                 height: 12,
//                               ),
//                               GridView.builder(
//                                 padding: EdgeInsets.zero,
//                                 itemCount:
//                                     awardController.allFeaturedServices.length,
//                                 physics: const BouncingScrollPhysics(),
//                                 shrinkWrap: true,
//                                 gridDelegate:
//                                     SliverGridDelegateWithFixedCrossAxisCount(
//                                         crossAxisCount: 2,
//                                         mainAxisSpacing: 6,
//                                         mainAxisExtent: Get.height * .35,
//                                         crossAxisSpacing: 6),
//                                 itemBuilder: (context, index) {
//                                   final service = awardController
//                                       .allFeaturedServices[index];
//                                   return Container(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 4, vertical: 6),
//                                     decoration: ShapeDecoration(
//                                       color: Colors.white,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                     ),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         Stack(
//                                           alignment: Alignment.centerLeft,
//                                           children: [
//                                             Container(
//                                               width: double.infinity,
//                                               height: 118,
//                                               decoration: const ShapeDecoration(
//                                                 shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.only(
//                                                     topLeft: Radius.circular(5),
//                                                     topRight:
//                                                         Radius.circular(5),
//                                                   ),
//                                                 ),
//                                               ),
//                                               child: ClipRRect(
//                                                 borderRadius:
//                                                     BorderRadius.circular(5),
//                                                 child: Image.network(
//                                                   'https://images.unsplash.com/photo-1719122180607-66d0c7d5c26c?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
//                                                   fit: BoxFit.cover,
//                                                 ),
//                                               ),
//                                             ),
//                                             Positioned(
//                                               left: 0,
//                                               bottom: 12,
//                                               child: Container(
//                                                 padding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 7.43,
//                                                         vertical: 2.97),
//                                                 decoration:
//                                                     const ShapeDecoration(
//                                                   color: Color(0xFFFFCE58),
//                                                   shape: RoundedRectangleBorder(
//                                                     borderRadius:
//                                                         BorderRadius.only(
//                                                       topRight: Radius.circular(
//                                                           14.85),
//                                                       bottomRight:
//                                                           Radius.circular(
//                                                               14.85),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 child: const Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.start,
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.center,
//                                                   children: [
//                                                     Text(
//                                                       'Featured',
//                                                       style: TextStyle(
//                                                         color:
//                                                             Color(0xFF131A22),
//                                                         fontSize: 11.88,
//                                                         fontWeight:
//                                                             FontWeight.w400,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         const SizedBox(height: 8),
//                                         Column(
//                                           mainAxisSize: MainAxisSize.min,
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.center,
//                                           children: [
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 const Text(
//                                                   '6 Days Ago',
//                                                   style: TextStyle(
//                                                     color: Color(0xB2131A22),
//                                                     fontSize: 10,
//                                                     fontWeight: FontWeight.w400,
//                                                   ),
//                                                 ),
//                                                 Row(
//                                                   children: [
//                                                     const Icon(
//                                                       Icons.favorite,
//                                                       size: 16,
//                                                       color: Colors.green,
//                                                     ),
//                                                     Text(
//                                                       service.likes.toString(),
//                                                       style: const TextStyle(
//                                                         color:
//                                                             Color(0xB2131A22),
//                                                         fontSize: 10,
//                                                         fontWeight:
//                                                             FontWeight.w400,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                             const SizedBox(height: 6),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.start,
//                                               children: [
//                                                 Flexible(
//                                                   child: Text(
//                                                     service.vendorService
//                                                             ?.service?.title
//                                                             .toString() ??
//                                                         '',
//                                                     overflow:
//                                                         TextOverflow.ellipsis,
//                                                     style: const TextStyle(
//                                                       color: Color(0xFF131A22),
//                                                       fontSize: 13,
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             const SizedBox(height: 6),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   service.vendorService
//                                                           ?.fixedPrice
//                                                           .toString() ??
//                                                       '',
//                                                   textAlign: TextAlign.center,
//                                                   style: const TextStyle(
//                                                     color: Color(0xFF109B0E),
//                                                     fontSize: 10,
//                                                     fontWeight: FontWeight.w500,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             const SizedBox(height: 6),
//                                             Row(
//                                               mainAxisSize: MainAxisSize.min,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 const Icon(
//                                                   Icons.location_pin,
//                                                   color: Colors.amber,
//                                                   size: 18,
//                                                 ),
//                                                 const SizedBox(width: 3),
//                                                 Flexible(
//                                                   fit: FlexFit.tight,
//                                                   child: Text(
//                                                     service
//                                                             .vendorService
//                                                             ?.service
//                                                             ?.description
//                                                             .toString() ??
//                                                         '',
//                                                     maxLines: 2,
//                                                     overflow:
//                                                         TextOverflow.ellipsis,
//                                                     style: const TextStyle(
//                                                       color: Color(0xCC131A22),
//                                                       fontSize: 12,
//                                                       fontWeight:
//                                                           FontWeight.w400,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             const SizedBox(height: 6),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: [
//                                                 Expanded(
//                                                   child: InkWell(
//                                                     onTap: () {
//                                                       _showDeleteDialog(
//                                                           context, service.id?.toInt()??0);
//                                                     },
//                                                     child: Container(
//                                                       height: 22,
//                                                       padding: const EdgeInsets
//                                                           .symmetric(
//                                                           vertical: 2),
//                                                       decoration:
//                                                           ShapeDecoration(
//                                                         shape:
//                                                             RoundedRectangleBorder(
//                                                           side: const BorderSide(
//                                                               width: 1,
//                                                               color: Color(
//                                                                   0xFF109B0E)),
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(4),
//                                                         ),
//                                                       ),
//                                                       child: Row(
//                                                         mainAxisSize:
//                                                             MainAxisSize.min,
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .center,
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .center,
//                                                         children: [
//                                                           awardController
//                                                                   .isLoading
//                                                                   .value
//                                                               ? const CircularProgressIndicator()
//                                                               : const Text(
//                                                                   'Delete',
//                                                                   style:
//                                                                       TextStyle(
//                                                                     color: Color(
//                                                                         0xFF109B0E),
//                                                                     fontSize:
//                                                                         12,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w400,
//                                                                   ),
//                                                                 ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 const SizedBox(width: 6),
//                                                 Expanded(
//                                                   child: Container(
//                                                     height: 22,
//                                                     padding: const EdgeInsets
//                                                         .symmetric(vertical: 2),
//                                                     decoration: ShapeDecoration(
//                                                       color: const Color(
//                                                           0xFFFFCE58),
//                                                       shape:
//                                                           RoundedRectangleBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           4)),
//                                                     ),
//                                                     child: const Row(
//                                                       mainAxisSize:
//                                                           MainAxisSize.min,
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .center,
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .center,
//                                                       children: [
//                                                         Text(
//                                                           'Detail',
//                                                           style: TextStyle(
//                                                             color: Color(
//                                                                 0xE5131A22),
//                                                             fontSize: 12,
//                                                             fontWeight:
//                                                                 FontWeight.w400,
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
                      
//     );
//   }

  
//   void _showDeleteDialog(BuildContext context, int serviceId) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Confirm Deletion'),
//           content: const Text('Are you sure you want to delete this service?'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: const Text('Delete'),
//               onPressed: () {
//                 awardController.deleteVendorService(serviceId);
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }