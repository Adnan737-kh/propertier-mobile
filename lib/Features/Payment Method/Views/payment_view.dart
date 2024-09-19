import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:propertier/constant/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentView extends StatefulWidget {
  PaymentView({super.key, required this.urls});

  String urls;

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  late final WebViewController webViewController;

  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            // Get.back();
          },
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.urls));
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          systemNavigationBarContrastEnforced: true,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: AppColor.primaryColor,
          statusBarColor: AppColor.white),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            foregroundColor: AppColor.white,
            title: const Text("Payment View"),
            centerTitle: true,
            backgroundColor: AppColor.secondaryColor,
          ),
          body: WebViewWidget(
            controller: webViewController,
          ),
        ),
      ),
    );
  }
}

class ChatbotController extends GetxController {
  var url = Get.arguments as String;

  var isLoading = true.obs;

  void setLoading(bool value) {
    isLoading.value = value;
  }
}
