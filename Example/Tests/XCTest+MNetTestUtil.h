//
//  XCTest+MNetTestUtil.h
//  MNetAdSdk_Tests
//
//  Created by kunal.ch on 26/09/18.
//  Copyright © 2018 kunal5692. All rights reserved.
//

#import <XCTest/XCTest.h>

#define FILENAME_BANNER_320x50          @"adResponseBanner320x50"
#define FILENAME_BANNER_AD_URL_320x50   @"adResponseBannerAdUrl320x50"
#define FILENAME_BANNER_300x250         @"adResponseBanner300x250"
#define FILENAME_VIDEO_320x250          @"adResponseVideo320x250"
#define FILENAME_REWARDED_VIDEO         @"rewardedResponseVideo320x250"
#define FILENAME_INVALID_REWARDED_VIDEO @"invalidRewardedResponseVideo320x250"
#define INVALID_FILENAME_VIDEO          @"noAdResponse"
#define FILENAME_CONFIG_FILE            @"MNetSdkConfigResponse"
#define FILENAME_BANNER_INVALID_SIZE    @"adResponseWithInvalidSize"

@interface XCTest (MNetTestUtil)
- (void)setupClass:(Class)className;
- (void)validateBannerAdRequestStubForClass:(Class)className;
- (void)invalidBannerAdRequestStubForClass:(Class)className;
@end
