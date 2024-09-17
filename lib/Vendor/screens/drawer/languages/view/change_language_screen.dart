import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:propertier/Vendor/screens/widgets/round_checkbox.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({super.key});

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  List<String> cityData = [
    'Urdu',
    'Saraiki',
    'Punjabi',
    'Sindhi',
    'Balochi',
    'Pashto',
  ];
  List<int> boxValues = List.filled(6, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // height: Get.height * .1,
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
                    height: 33,
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
                            'Languages',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 22),
                        child: SvgPicture.asset('assets/wallet.svg'),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    height: Get.height * .048,
                    width: Get.width * .9,
                    child: TextFormField(
                      cursorColor: Colors.amber,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        // contentPadding: EdgeInsets.symmetric(
                        //     vertical: MediaQuery.of(context).size.width * 0.020,
                        //     horizontal: 8),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(33),
                            borderSide:
                                const BorderSide(color: Colors.black12)),
                        hintText: 'Search language...',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(33),
                        ),
                        prefixIcon: const Icon(Icons.search),
                        hintStyle: const TextStyle(
                          color: Color(0xFF828A89),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        isDense: true,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 39,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Languages:',
                    style: TextStyle(
                      color: Color(0xFF1E1E1E),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 20),
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
                              RoundCheckbox(
                                activeColor: Colors.grey,
                                value: true,
                                onChanged: (value) {},
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 12,
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: Get.height * .04,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: Get.size.width,
                      height: Get.height * .071,
                      // height: 58,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFDCD54),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Color(0xFF131A22),
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
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
