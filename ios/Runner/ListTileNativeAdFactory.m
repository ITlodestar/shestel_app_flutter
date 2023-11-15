// TODO: Import ListTileNativeAdFactory.h
#import "ListTileNativeAdFactory.h"

// TODO: Implement ListTileNativeAdFactory
@implementation ListTileNativeAdFactory

- (GADNativeAdView *)createNativeAd:(GADNativeAd *)nativeAd
                             customOptions:(NSDictionary *)customOptions {
  GADNativeAdView *nativeAdView =
    [[NSBundle mainBundle] loadNibNamed:@"ListTileNativeAdView" owner:nil options:nil].firstObject;

  ((UILabel *)nativeAdView.headlineView).text = nativeAd.headline;

  ((UILabel *)nativeAdView.bodyView).text = nativeAd.body;
  nativeAdView.bodyView.hidden = nativeAd.body ? NO : YES;

  ((UIImageView *)nativeAdView.iconView).image = nativeAd.icon.image;
  nativeAdView.iconView.hidden = nativeAd.icon ? NO : YES;

  nativeAdView.callToActionView.userInteractionEnabled = NO;

  nativeAdView.nativeAd = nativeAd;

  return nativeAdView;
}

@end
