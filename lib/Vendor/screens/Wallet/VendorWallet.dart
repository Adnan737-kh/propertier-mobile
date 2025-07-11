import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/Vendor/screens/Wallet/VendorWalletController.dart';
import 'package:propertier/constant/colors.dart';


class VendorWallet extends GetView<VendorWalletController> {
  const VendorWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text("Wallet"),
        backgroundColor: AppColor.forGroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance Section
            Container(
              width: Get.width,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  const Text(
                    "Wallet Balance",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Obx(()=> Text(
                    "\$${controller.balance.value.toStringAsFixed(2)}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  )),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Enter Amount'),
                            content: Form(
                              key: controller.formKey,
                              child: TextFormField(
                                controller: controller.priceController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Amount',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter amount';
                                  }
                                  if (int.tryParse(value) == null) {
                                    return 'Please enter a valid integer';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                                child: const Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () async{
                                  if (controller.formKey.currentState!.validate()) {
                                    // Price is valid
                                    final price = int.parse(controller.priceController.text);
                                    await controller.walletTestPayment(price);
                                    // double totalPrice = controller.balance.value + price;
                                    // print('Entered Price: $totalPrice');
                                    // controller.updateBalance(totalPrice);
                                    Navigator.of(context).pop(); // Close the dialog
                                  }
                                },
                                child: const Text('Continue'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.forGroundColor,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Top Up", style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Transactions Section
            // Text(
            //   "Recent Transactions",
            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: controller.transactions.length,
                itemBuilder: (context, index) {
                  final transaction = controller.transactions[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(15),
                      leading: CircleAvatar(
                        backgroundColor: transaction["amount"]!.startsWith("+")
                            ? Colors.green
                            : Colors.red,
                        child: const Icon(
                          Icons.attach_money,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(transaction["description"]!),
                      subtitle: Text(transaction["date"]!),
                      trailing: Text(
                        transaction["amount"]!,
                        style: TextStyle(
                          color: transaction["amount"]!.startsWith("+")
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}