import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../functions/ad_helper.dart';

class NativeAds extends StatefulWidget {
  final EdgeInsetsGeometry padding;
  NativeAds({
    this.padding=const EdgeInsets.only(left:12.0, right:12.0, bottom: 12.0),
    Key? key
  }) : super(key: key);

  @override
  State<NativeAds> createState() => _NativeAdsState();
}

class _NativeAdsState extends State<NativeAds> {
  NativeAd? _ad;

  @override
  void initState() {
    // TODO: implement initState

    NativeAd(
      adUnitId: AdHelper.nativeAdUnitId,
      factoryId: 'listTile',
      request: AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _ad = ad as NativeAd;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();
          print('Ad load failed (code=${error.code} message=${error.message})');       },
      ),
    ).load();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return _ad!=null?Padding(
      padding: widget.padding,
      child: Container(
          clipBehavior: Clip.hardEdge,
          height:60,

          decoration: BoxDecoration(color: Colors.white,
              borderRadius: BorderRadius.circular(8)
          ),
          // width: MediaQuery.of(context).size.width,
          child: AdWidget(ad: _ad!)),
    ):Container();
  }
}
