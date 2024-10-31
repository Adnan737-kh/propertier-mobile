import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/Vendor/screens/dashboard/home/view/select_location_screen.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final _categories = <String>[
    '2000',
    '4000',
    '10000',
    '15000',
    '20000',
    '40000',
  ];

  String? _category;
  //  final _marlays = <String>[
  //   '5',
  //   '10',
  //   '15',
  //   '20',
  //   '40',
  //   '80',
  // ];

  // String? _marla;

  List<String> marlaData = [
    '5 Marla'
        '10 Marla'
        '20 Marla'
        '30 Marla'
        '40 Marla'
        '60 Marla'
        '80 Marla'
        '100 Marla'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: Get.height * .124,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: const ShapeDecoration(
                color: Color(0xFF131A22),
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 44,
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
                              ),
                              ),
                          const SizedBox(
                            width: 2,
                          ),
                          const Text(
                            'Filter',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 14),
                        child: Text(
                          'Done',
                          style: TextStyle(
                            color: Color(0xFFFDCD54),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 40,
                        width: Get.width * .7,
                        child: TextFormField(
                          cursorColor: Colors.red,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.width * 0.020,
                                horizontal: 8),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(33),
                                borderSide:
                                    const BorderSide(color: Colors.black12)),
                            hintText: 'Search here',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(33),
                            ),
                            hintStyle: const TextStyle(
                              color: Color(0xFF828A89),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            isDense: true,
                            suffixIcon: const Icon(Icons.search),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => SelectLocationScreen());
                        },
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 7),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 0.40,
                                strokeAlign: BorderSide.strokeAlignCenter,
                                color: Color(0x26131A22),
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.location_pin,
                                color: Color(0xFFFDCD54),
                              ),
                              Text(
                                'Map',
                                style: TextStyle(
                                  color: Color(0xFF131A22),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Price Range',
                        style: TextStyle(
                          color: Color(0x99131A22),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // SizedBox(
                      //   width: Get.width*.34,
                      // ),
                      SizedBox(
                        height: Get.height * .034,
                        width: Get.width * .22,
                        child: DropdownButtonFormField<String>(
                          value: _category,
                          hint: const Text('PKR'),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 4 ,left: 6,right: 6),
                              fillColor: const Color(0x05131A22),
                              enabledBorder: OutlineInputBorder(
                                   borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.black
                                      .withOpacity(0.20000000298023224),
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.black
                                      .withOpacity(0.20000000298023224),
                                ),
                                borderRadius: BorderRadius.circular(5),
                              )),
                          style: const TextStyle(
                            color: Color(0x66131A22),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          isExpanded: true,
                          items: _categories.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _category = newValue.toString();
                            });
                          },
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Get.width * .34,
                        height: Get.height * .036,
                        child: TextFormField(
                          decoration: InputDecoration(
                              isDense: true,
                              enabledBorder: OutlineInputBorder(
                                   borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.black
                                      .withOpacity(0.20000000298023224),
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.black
                                      .withOpacity(0.20000000298023224),
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.height *
                                      0.008,
                                  horizontal: 6),
                              hintStyle: const TextStyle(
                                color: Color(0xFF828A89),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              hintText: 'Minimun'),
                        ),
                      ),
                      Container(
                        width: 14,
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              strokeAlign: BorderSide.strokeAlignCenter,
                              color: Color(0xFFBBBBBB),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Get.width * .34,
                        height: Get.height * .036,
                        child: TextFormField(
                          decoration: InputDecoration(
                              isDense: true,
                               enabledBorder: OutlineInputBorder(
                                   borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.black
                                      .withOpacity(0.20000000298023224),
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.black
                                      .withOpacity(0.20000000298023224),
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.height *
                                      0.008,
                                  horizontal: 6),
                              hintStyle: const TextStyle(
                                color: Color(0xFF828A89),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              hintText: 'Maximum'),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 66,
                  ),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.min,
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       const Text(
                  //         'Area ',
                  //         style: TextStyle(
                  //           color: Color(0x99131A22),
                  //           fontSize: 14,
                  //           fontWeight: FontWeight.w500,
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 28,
                  //         width: Get.width * .3,
                  //         child: DropdownButtonFormField<String>(
                  //           decoration: InputDecoration(
                  //             contentPadding: EdgeInsets.symmetric(
                  //                 vertical:
                  //                     MediaQuery.of(context).size.height * 0.03,
                  //                 horizontal: 6),
                  //             hintText: 'Marla',
                  //             hintStyle: const TextStyle(
                  //               color: Color(0xFF131A22),
                  //               fontSize: 12,
                  //               fontWeight: FontWeight.w400,
                  //             ),
                  //             border: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(4),
                  //               borderSide: const BorderSide(color: Colors.black),
                  //             ),
                  //             enabledBorder: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(4),
                  //               borderSide:
                  //                   const BorderSide(color: Colors.black38),
                  //             ),
                  //             focusedBorder: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(4),
                  //               borderSide:
                  //                   const BorderSide(color: Colors.black38),
                  //             ),
                  //           ),
                  //           value: _marla,
                  //           validator: (value) {
                  //             if (value == null) {
                  //               return 'Please select a category';
                  //             }
                  //             return null;
                  //           },
                  //           onChanged: (value) {
                  //             setState(() {
                  //               _marla = value;
                  //             });
                  //           },
                  //           items: _marlays
                  //               .map(
                  //                 (e) => DropdownMenuItem(
                  //                   value: e,
                  //                   child: Text(e),
                  //                 ),
                  //               )
                  //               .toList(),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(height: 24),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     SizedBox(
                  //       width: Get.width * .34,
                  //       height: Get.height * .036,
                  //       child: TextFormField(
                  //         decoration: InputDecoration(
                  //             isDense: true,
                  //             border: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(4),
                  //               borderSide: const BorderSide(color: Colors.black),
                  //             ),
                  //             enabledBorder: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(4),
                  //               borderSide:
                  //                   const BorderSide(color: Colors.black38),
                  //             ),
                  //             focusedBorder: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(4),
                  //               borderSide:
                  //                   const BorderSide(color: Colors.black38),
                  //             ),
                  //             contentPadding: EdgeInsets.symmetric(
                  //                 vertical:
                  //                     MediaQuery.of(context).size.height * 0.008,
                  //                 horizontal: 6),
                  //             hintStyle: const TextStyle(
                  //               color: Color(0xFF828A89),
                  //               fontSize: 14,
                  //               fontWeight: FontWeight.w400,
                  //             ),
                  //             hintText: 'Minimun'),
                  //       ),
                  //     ),
                  //     Container(
                  //       width: 14,
                  //       decoration: const ShapeDecoration(
                  //         shape: RoundedRectangleBorder(
                  //           side: BorderSide(
                  //             width: 1,
                  //             strokeAlign: BorderSide.strokeAlignCenter,
                  //             color: Color(0xFFBBBBBB),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: Get.width * .34,
                  //       height: Get.height * .036,
                  //       child: TextFormField(
                  //         decoration: InputDecoration(
                  //             isDense: true,
                  //             border: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(4),
                  //               borderSide: const BorderSide(color: Colors.black),
                  //             ),
                  //             enabledBorder: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(4),
                  //               borderSide:
                  //                   const BorderSide(color: Colors.black38),
                  //             ),
                  //             focusedBorder: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(4),
                  //               borderSide:
                  //                   const BorderSide(color: Colors.black38),
                  //             ),
                  //             contentPadding: EdgeInsets.symmetric(
                  //                 vertical:
                  //                     MediaQuery.of(context).size.height * 0.008,
                  //                 horizontal: 6),
                  //             hintStyle: const TextStyle(
                  //               color: Color(0xFF828A89),
                  //               fontSize: 14,
                  //               fontWeight: FontWeight.w400,
                  //             ),
                  //             hintText: 'Maximum'),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 36,
                  // ),
                  // const Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       ChipWidget(text: '5 Marla'),
                  //       ChipWidget(text: '10 Marla'),
                  //       ChipWidget(text: '20 Marla'),
                  //       ChipWidget(text: '30 Marla'),
                  //     ]),
                  // const SizedBox(
                  //   height: 8,
                  // ),
                  // const Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       ChipWidget(text: '40 Marla'),
                  //       ChipWidget(text: '60 Marla'),
                  //       ChipWidget(text: '80 Marla'),
                  //       ChipWidget(text: '90 Marla'),
                  //     ]),
                  SizedBox(
                    height: Get.height * .48,
                  ),
                  Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            height: 33,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  width: 1,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  color: Color(0xFF109B0E),
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Clear All',
                                  style: TextStyle(
                                    color: Color(0xFF109B0E),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                            child: Container(
                          height: 33,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: ShapeDecoration(
                            color: const Color(0xFFFDCD54),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 0.40,
                                strokeAlign: BorderSide.strokeAlignCenter,
                                color: Color(0x19131A22),
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Submit',
                                style: TextStyle(
                                  color: Color(0xFF131A22),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ))
                      ])
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
