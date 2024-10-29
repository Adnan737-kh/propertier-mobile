import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';





Future<bool> loadAndShowInterstitialAd() async {
  Completer<bool> completer = Completer<bool>();
  InterstitialAd? _interstitialAd;

  // show add randomly
  int num =  getRandomZeroOrOne();
  print("************* $num");
  if(num == 0){
    completer.complete(false);
    return completer.future;
  }

  // Load the interstitial ad only when navigating
  InterstitialAd.load(
    adUnitId: 'ca-app-pub-3940256099942544/1033173712', // Replace with your Ad Unit ID
    request: AdRequest(),
    adLoadCallback: InterstitialAdLoadCallback(
      onAdLoaded: (InterstitialAd ad) {
        _interstitialAd = ad;

        // Show the ad
        _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (InterstitialAd ad) {
            ad.dispose();
            completer.complete(true); // Ad closed successfully
          },
          onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
            ad.dispose();
            completer.complete(false); // Failed to show ad
          },
        );
        _interstitialAd!.show();
      },
      onAdFailedToLoad: (LoadAdError error) {
        print('InterstitialAd failed to load: $error');
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
