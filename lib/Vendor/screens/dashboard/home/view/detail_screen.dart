import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this for rootBundle
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:propertier/Vendor/screens/dashboard/home/view/component/amount.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late GoogleMapController mapController;
  bool isDescriptionExpanded = false;
  bool isMapSelected = true;
  bool isImageSelected = false;

  final LatLng _initialPosition = const LatLng(33.6844, 73.0479);
  
  // Variable to store the map style
  String? mapStyle;

  @override
  void initState() {
    super.initState();
    loadMapStyle(); // Load the map style when the widget is initialized
  }

  Future<void> loadMapStyle() async {
    // Load the JSON file
    mapStyle = await rootBundle.loadString('assets/map.json');
    // Trigger a rebuild once the style is loaded
    setState(() {});
  }

  // Function to show amount input screen as a bottom sheet
  void showAmountInput() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const KeypadScreen();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: <Widget>[
                if (isMapSelected && mapStyle != null) // Check if mapStyle is loaded
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _initialPosition,
                      zoom: 14.0,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      mapController = controller;
                      mapController.setMapStyle(mapStyle); // Apply the custom map style
                    },
                    markers: {
                      const Marker(
                        markerId: MarkerId('start'),
                        position: LatLng(33.6844, 73.0479),
                      ),
                      const Marker(
                        markerId: MarkerId('end'),
                        position: LatLng(33.6144, 73.0551),
                      ),
                    },
                  )
                else
                  const Center(
                    child: CircularProgressIndicator(), // Show a loading indicator while loading the map style
                  ),

                // Back button positioned at the top-left of the screen
                Positioned(
                  top: 40,
                  left: 10,
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),

          // Bottom section with buttons, location info, description, and options
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Color(0xFFF6F6F6),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Buttons Row (Map and Image toggle)
                Container(
                  height: Get.height * .08,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      Container(
                        height: Get.height * .05,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isMapSelected = true;
                                    isImageSelected = false;
                                  });
                                },
                                child: Container(
                                  padding: isMapSelected
                                      ? const EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 20)
                                      : const EdgeInsets.symmetric(vertical: 6),
                                  decoration: BoxDecoration(
                                    color: isMapSelected
                                        ? const Color(0xFFFDCD54)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  margin: isMapSelected
                                      ? const EdgeInsets.symmetric(horizontal: 2)
                                      : EdgeInsets.zero,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.map,
                                          color: isMapSelected
                                              ? Colors.white
                                              : Colors.black),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Map',
                                        style: TextStyle(
                                          color: isMapSelected
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isMapSelected = false;
                                    isImageSelected = true;
                                  });
                                },
                                child: Container(
                                  padding: isImageSelected
                                      ? const EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 20)
                                      : const EdgeInsets.symmetric(vertical: 6),
                                  decoration: BoxDecoration(
                                    color: isImageSelected
                                        ? const Color(0xFFFDCD54)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  margin: isImageSelected
                                      ? const EdgeInsets.symmetric(horizontal: 2)
                                      : EdgeInsets.zero,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.image,
                                          color: isImageSelected
                                              ? Colors.white
                                              : Colors.black),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Images',
                                        style: TextStyle(
                                          color: isImageSelected
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ],
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
                const SizedBox(height: 10),

                // Location Row with dotted line
                // Location Row with dotted line
Container(
  // margin: const EdgeInsets.symmetric(vertical: 10), // Add vertical margin for spacing between other elements
  padding: const EdgeInsets.all(10), // Add padding inside the container
  decoration: BoxDecoration(
    color: const Color(0xFFFFFFFF), // Set background color to white
    borderRadius: BorderRadius.circular(8.0), // Rounded corners
  ),
  child: Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Transform.translate(
                      offset: const Offset(0, -2),
                      child: const Icon(Icons.radio_button_checked, color: Colors.black),
                    ),
                    // Dotted vertical line extending to location icon
                    Container(
                      width: 1,
                      height: 20, // Adjust this height as needed
                      decoration: const BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    const Icon(Icons.location_on, color: Color(0xFFFDCD54)),
                  ],
                ),
                const SizedBox(width: 20),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bahria Town Phase 7',
                       style: const TextStyle(
                color: Color(0xFF1F0101),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
                      ),
                      SizedBox(height: 15), // Adjust this value to reduce the space
                      Divider(
                        color: Colors.grey,
                        thickness: 1.0,
                        indent: 2, // Adjust as needed
                        endIndent: 5, // Adjust as needed
                        height: 1,
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Kachari Chowk Main Rawalpindi',
                       style: const TextStyle(
                color: Color(0xFF1F0101),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          '5 KM',
          style: TextStyle(color: Colors.black),
        ),
      ),
    ],
  ),
),


const SizedBox(height: 10),
const Divider(),
const SizedBox(height: 10),

// Description Section
Container(
  decoration: BoxDecoration(
    color: const Color(0xFFFFFFFF), // Set background color to white
    borderRadius: BorderRadius.circular(8.0), // Rounded corners
  ),
  padding: const EdgeInsets.all(16.0), // Add padding for the container
  child: GestureDetector(
    onTap: () {
      setState(() {
        isDescriptionExpanded = !isDescriptionExpanded;
      });
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Description Detail',
            style: const TextStyle(
                color: Color(0xFF1F0101),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            Icon(
              isDescriptionExpanded
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
              color: Colors.black,
            ),
          ],
        ),
        if (isDescriptionExpanded)
          const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              'Lorem ipsum dolor sit amet consectetur. Id fermentum sodales at aliquet facilisi ultrices ornare quis sit. Eget luctus consectetur morbi egestas. Imperdiet eget ultricies odio at amet.',
              style: TextStyle(color: Colors.grey),
            ),
          ),
      ],
    ),
  ),
),

const SizedBox(height: 10),

                const SizedBox(height: 10),

                // Options Buttons Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const OptionButton(text: '2150'),
                    const OptionButton(text: '2800'),
                    const OptionButton(text: '3000'),
                    // When edit icon is clicked, show the amount input screen
                    // Modify this part in the options row
GestureDetector(
  onTap: () {
    // Show bottom sheet when user taps the edit icon
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,  // Makes the bottom sheet cover the screen
      backgroundColor: Colors.transparent, // Set the background color to transparent
      builder: (BuildContext context) {
        return const KeypadScreen();
      },
    );
  },
  child: Icon(Icons.edit, color: Colors.grey),
),


                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Button Widget for Options
class OptionButton extends StatelessWidget {
  final String text;
  const OptionButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFFFFFF),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: () {},
      child: Text(
        text,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}

