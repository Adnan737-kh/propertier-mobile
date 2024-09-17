import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  List<String> cityData = [
    'Lahore',
    'Karachi',
    'Multan',
    'Lodhran',
    'Rawat',
    'Islamabad',
  ];
  List<int> boxValues = List.filled(6, 0);

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
                  borderRadius: BorderRadius.only(
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
                              )),
                          const SizedBox(
                            width: 2,
                          ),
                          const Text(
                            'Location',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          )
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
                      Container(
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
                      )
                    ],
                  ),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: cityData.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                cityData[index].toString(),
                                style: const TextStyle(
                                  color: Color(0xB2131A22),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Checkbox(
                                checkColor: Colors.white,
                                activeColor: Colors.amber,
                                // value: boxValues[index] == 1,
                                value: true,
                                onChanged: (value) {
                                  setState(() {
                                    boxValues[index] = value! ? 1 : 0;
                                  });
                                },
                              ),
                            ],
                          ),
                          const Divider()
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: Get.height * .24,
                  ),
                  Container(
                    height: 38,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Confirm',
                          style: TextStyle(
                            color: Color(0xFF131A22),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
