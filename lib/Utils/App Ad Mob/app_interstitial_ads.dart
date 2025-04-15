import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future<bool> loadAndShowInterstitialAd({bool flag = false}) async {
  Completer<bool> completer = Completer<bool>();
  InterstitialAd? interstitialAd;

  // show add randomly
  int num =  getRandomZeroOrOne();

  if(num == 0 && flag == false){
    completer.complete(false);
    return completer.future;
  }

  String adUnitId = Platform.isAndroid
      ? 'ca-app-pub-9403488694655871/2212565520'
      : 'ca-app-pub-9403488694655871/2072092584';

  // Load the interstitial ad only when navigating
  InterstitialAd.load(
    adUnitId: adUnitId, // Replace with your Ad Unit ID
    request: const AdRequest(),
    adLoadCallback: InterstitialAdLoadCallback(
      onAdLoaded: (InterstitialAd ad) {
        interstitialAd = ad;

        // Show the ad
        interstitialAd!.fullScreenContentCallback =
            FullScreenContentCallback(
          onAdDismissedFullScreenContent: (InterstitialAd ad) {
            ad.dispose();
            completer.complete(true); // Ad closed successfully
          },
          onAdFailedToShowFullScreenContent: (InterstitialAd ad,
              AdError error) {
            ad.dispose();
            completer.complete(false); // Failed to show ad
          },
        );
        interstitialAd!.show();
      },
      onAdFailedToLoad: (LoadAdError error) {
        if (kDebugMode) {
          print('InterstitialAd failed to load: $error');
        }
        completer.complete(false); // Failed to load ad
      },
    ),
  );

  return completer.future;
}


int getRandomZeroOrOne() {
  Random random = Random();
  return random.nextInt(4); // Generates either 0 or 1
}
