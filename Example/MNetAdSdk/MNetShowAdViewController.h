//
//  MNetShowAdViewController.h
//  MNetAdSdk_Example
//
//  Created by kunal.ch on 21/09/18.
//  Copyright © 2018 kunal5692. All rights reserved.
//

#import <MNetAdSdk/MNetAdView.h>
#import <MNetAdSdk/MNetInterstitialAd.h>
#import <MNetAdSdk/MNetRewardedVideo.h>
#import <UIKit/UIKit.h>

#define ENUM_VAL(enum) [NSNumber numberWithInt:enum]
@import GoogleMobileAds;
@import MoPub;

@interface MNetShowAdViewController
    : UIViewController <MNetVideoDelegate, MNetAdViewDelegate, MNetAdViewSizeDelegate, MNetInterstitialAdDelegate,
                        MNetRewardedVideoDelegate, MNetInterstitialVideoAdDelegate, GADBannerViewDelegate,
                        GADInterstitialDelegate, MPAdViewDelegate, MPInterstitialAdControllerDelegate>

typedef enum {
    BNR,
    BNR_INTR,
    BNR_VIDEO,
    VIDEO_INTR,
    VIDEO_REWARDED,
    MRAID_BANNER,
    MRAID_INTERSTITIAL,
    DFP_MEDIATION,
    MOPUB_MEDIATION,
    ADMOB_MEDIATION,
    DFP_INTERSTITIAL_MEDIATION,
    MOPUB_INTERSTITIAL_MEDIATION,
    ADMOB_INTERSTITIAL_MEDIATION,
} MNetAdType;

- (IBAction)loadAd:(id)sender;
- (IBAction)showAd:(id)sender;

@property (nonatomic) MNetAdType adType;
@end
