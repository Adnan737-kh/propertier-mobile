import 'package:easypaisa_flutter/easypaisa_flutter.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:propertier/App/Language/ViewModel/language_view_model.dart';
import 'package:propertier/RoutesAndBindings/app_pages.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/constant/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'App/NavBar/ViewModel/navbar_view_model.dart';
import 'App/Post Add/Add Properties/ViewModel/add_properties_view_model.dart';
import 'App/Profile/ViewModel/profile_view_model.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  var initializationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = const DarwinInitializationSettings();
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  EasypaisaFlutter.initialize(
      'propertier.com@gmail.com', 'Anees@716', '512654', true, AccountType.MA);
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity,
    //  webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );
  await GetStorage.init();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((val) => runApp(
            // DevicePreview(
            // enabled: !kReleaseMode,
            // builder: (context) =>
            MyApp(),
            // ),
          ));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});

  var platform = const MethodChannel('splashcolor');
  final _languageViewModel = Get.put(LanguageViewModel());

  @override
  Widget build(BuildContext context) {
    Get.put(NavBarViewModel());
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: AppColor.backgroundColor,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: AppColor.backgroundColor),
    );

    return GetMaterialApp(
      initialBinding: InitialBindings(),
      useInheritedMediaQuery: true,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(_languageViewModel.selectedLanguageCode),
      title: 'Propertier',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColor.backgroundColor,
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColor.secondaryColor,
        ),
        useMaterial3: false,
        navigationBarTheme: const NavigationBarThemeData(
            backgroundColor: Colors.transparent,
            elevation: 0,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent),
        scaffoldBackgroundColor: AppColor.backgroundColor,
      ),
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child!,
        );
      },
      getPages: AppPages.routes,
      initialRoute: AppRoutes.authView,
    );
  }

  void setSystemBarsColor(int statusBarColor, int navigationBarColor) {
    try {
      platform.invokeMethod('setSystemBarsColor', {
        'statusBarColor': statusBarColor,
        'navigationBarColor': navigationBarColor,
      });
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to set system bars color: '${e.message}'.");
      }
    }
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddPropertiesViewModel(), fenix: true);
    Get.lazyPut(() => ProfileViewModel(), fenix: true);
  }
}
