import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Widget buildAds(String unitID) {
  final myBanner = BannerAd(
    adUnitId: unitID,
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );
  myBanner.load();
  final AdWidget adWidget = AdWidget(ad: myBanner);
  return Container(
    alignment: Alignment.center,
    child: adWidget,
    width: myBanner.size.width.toDouble(),
    height: myBanner.size.height.toDouble(),
  );
}
