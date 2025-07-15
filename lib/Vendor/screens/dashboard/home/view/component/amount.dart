import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/Vendor/screens/dashboard/home/Controller/DetailScreenController.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/localization_extension.dart';

class KeypadScreen extends StatefulWidget {
  const KeypadScreen({super.key});

  @override
  _KeypadScreenState createState() => _KeypadScreenState();
}

class _KeypadScreenState extends State<KeypadScreen> {
DetailScreenController controller = Get.find();

  void _handleNumberInput(String number) {
    setState(() {
      if (controller.amountC.text == 'Enter amount') {
        controller.amountC.clear();
      }
      controller.amountC.text += number; // Append the new number
    });
  }

  void _handleBackspace() {
    setState(() {
      if (controller.amountC.text.isNotEmpty) {
        controller.amountC.text = controller.amountC.text.substring(0, controller.amountC.text.length - 1); // Remove last character
      }
    });
  }

  void _handleDoubleZero() {
    _handleNumberInput('00'); // Append double zero
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0), // Adds side padding
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color(0xffF2F2F2),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text(
                  context.local.enter_your_amount,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.textColor, // Text color
                  ),
                ),
                const SizedBox(height: 10),

                // TextField with horizontal padding
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12), // Adjusted padding
                  decoration: BoxDecoration(
                    color: AppColor.white, // Light background for the text field
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextField(
                    controller: controller.amountC, // Use the controller
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.none, // Disable keyboard
                    readOnly: true, // Make it read-only
                    decoration:  InputDecoration(
                      border: InputBorder.none,
                      hintText: context.local.enter_amount, // Hint text
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Action Buttons inside Expanded Row to match TextField width
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          controller.amount.value = controller.amountC.text;
                          Navigator.pop(context); // Close keypad
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 9), // Adjusted padding
                          backgroundColor: Colors.red, // Set background color to red
                        ),
                        child: const Icon(Icons.close, color: Colors.white), // Icon color white for contrast
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Save amount here
                          controller.amount.value = controller.amountC.text;
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 9), // Adjusted padding
                          backgroundColor: Colors.green, // Set background color to green
                        ),
                        child: const Icon(Icons.check, color: Colors.white), // Icon color white for contrast
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Separator between TextField and Dial Pad
          const SizedBox(height: 20), // Adjust height as needed

          // Numeric Keypad UI with black transparent background
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 0,
            ), // No horizontal padding
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6), // Black transparent background
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)), // Rounded top corners
            ),
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              shrinkWrap: true, // Ensures GridView does not expand infinitely
              physics: const NeverScrollableScrollPhysics(), // Prevent scrolling
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2.0,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 12, // Numbers 1 to 9, 00, 0, and backspace
              itemBuilder: (context, index) {
                if (index < 9) {
                  return KeypadButton(
                    text: '${index + 1}',
                    onTap: () => _handleNumberInput('${index + 1}'),
                  );
                } else if (index == 9) {
                  return KeypadButton(
                    text: '00',
                    onTap: _handleDoubleZero,
                  );
                } else if (index == 10) {
                  return KeypadButton(
                    text: '0',
                    onTap: () => _handleNumberInput('0'),
                  );
                } else {
                  return KeypadButton(
                    text: '<',
                    onTap: _handleBackspace,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Custom button widget for the keypad
class KeypadButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const KeypadButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFFFDCD54), // Darker background for buttons
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Ensure text contrast against dark background
          ),
        ),
      ),
    );
  }
}
