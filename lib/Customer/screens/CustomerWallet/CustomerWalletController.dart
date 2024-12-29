import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../../Network/api_urls.dart';


class CustomerWalletController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    customerId =  box.read('id').toString();
    getWallet();
  }



  RxDouble balance = 0.00.obs;

  final box = GetStorage();
  String? customerId;
  List<Map<String, String>> transactions = [
    // {"date": "Nov 18, 2024", "description": "Transport Service", "amount": "-10.0"},
    // {"date": "Nov 17, 2024", "description": "Top Up", "amount": "+50.0"},
    // {"date": "Nov 16, 2024", "description": "Plumber Service", "amount": "-20.0"},
    // {"date": "Nov 17, 2024", "description": "Top Up", "amount": "+50.0"},
    // {"date": "Nov 17, 2024", "description": "Top Up", "amount": "+50.0"},
    // {"date": "Nov 17, 2024", "description": "Top Up", "amount": "+50.0"},
    // {"date": "Nov 17, 2024", "description": "Top Up", "amount": "+50.0"},
  ];
  final TextEditingController priceController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<bool> updateBalance(double balance)async{
    bool flag = false;
    try{
      var data = {
        'balance': balance
      };
      var encodedData = jsonEncode(data);
      String url = "${API.topupWallet}$customerId/";
      print(url);
      var response = await http.put(Uri.parse(url),
          headers: <String, String>{'Content-Type': 'application/json'},
          body: encodedData);
      print(response.body);
      if(response.statusCode == 200){
        Fluttertoast.showToast(msg: "successful");
        flag = true;
        getWallet();
      }

    }
    catch(e){
      print(e);
    }

    return flag;
  }


  Future getWallet()async{
    try{
      String url = "${API.getWallet}$customerId";
      print(url);
      var response = await http.get(Uri.parse(url));
      print("********* ${response.statusCode}");
      print(response.body);
      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        balance.value = double.parse(data['balance']??"0.0");
      }
    }
    catch(e){
      print(e);
    }
  }


  Future walletTestPayment(int amount)async{
    try{
      String url = "${API.walletTestPayment}";
      print(url);
      var encodedBody = jsonEncode({
        'user_id': customerId,
        'amount': amount,
        'payment_methods': "card"
      });
      var response = await http.post(Uri.parse(url),
        body: encodedBody,
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      print(response.statusCode);
      print(response.body);
      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        print(data);
        String? url = data['redirect_url'];
        print(url);
        if(url != null){
          await openPaymentLink(url);
          double total = amount + balance.value;
          updateBalance(total);
          getWallet();
        }
      }
    }
    catch(e){
      print(e);
    }
  }


  Future openPaymentLink(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      print("URL can't be launched.");
    }
  }
}