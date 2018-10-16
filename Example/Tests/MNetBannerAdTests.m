//
//  MNetBannerAdTests.m
//  MNetAdSdk_Tests
//
//  Created by kunal.ch on 26/09/18.
//  Copyright © 2018 kunal5692. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNetTestManager.h"
#import <MNetAdSdk/MNetAdView.h>
#import "XCTest+MNetTestUtil.h"
#import "MNetDemoConstants.h"

@interface MNetBannerAdTests : MNetTestManager <MNetAdViewDelegate, MNetAdViewSizeDelegate>

@property (nonatomic) XCTestExpectation *bannerAdExpectation;

@end

@implementation MNetBannerAdTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testBannerAdLoad {
    [self validateBannerAdRequestStubForClass:[self class]];
    self.bannerAdExpectation = [self expectationWithDescription:@"Ad view loaded"];
    
    MNetAdView *bannerAd = [[MNetAdView alloc] initWithFrame:CGRectMake(0, 0, 320.0, 50.0)];
    [bannerAd setAdSize:MNetCreateAdSizeFromCGSize(kMNetBannerAdSize)];
    [bannerAd setAdUnitId:DEMO_MN_AD_UNIT_320x50];
    [bannerAd setRootViewController:[self getTopViewController]];
    [bannerAd setDelegate:self];
    [bannerAd loadAd];
    
    [self waitForExpectationsWithTimeout:30 handler:^(NSError * _Nullable error) {
        if(error){
            NSLog(@"Test timed out! - %@", error);
        }
    }];
}

- (void)testBannerAdUrlLoad{
    [self validateBannerAdRequestStubForClass:[self class]];
    self.bannerAdExpectation = [self expectationWithDescription:@"Ad view loaded"];
    
    MNetAdView *bannerAd = [[MNetAdView alloc] initWithFrame:CGRectMake(0, 0, 320.0, 50.0)];
    [bannerAd setAdSize:MNetCreateAdSizeFromCGSize(kMNetBannerAdSize)];
    [bannerAd setAdUnitId:DEMO_MN_AD_UNIT_320x50];
    [bannerAd setRootViewController:[self getTopViewController]];
    [bannerAd setDelegate:self];
    [bannerAd loadAd];
    
    [self waitForExpectationsWithTimeout:30 handler:^(NSError * _Nullable error) {
        if(error){
            NSLog(@"Test timed out! - %@", error);
        }
    }];
}

- (void)testBannerAdLoadWithMultipleAdSizes{
    [self validateBannerAdRequestStubForClass:[self class]];
    self.bannerAdExpectation = [self expectationWithDescription:@"Ad view loaded"];
    
    MNetAdView *bannerAd = [[MNetAdView alloc] init];
    [bannerAd setAdSizes:@[MNetCreateAdSizeFromCGSize(kMNetBannerAdSize), MNetCreateAdSizeFromCGSize(kMNetMediumAdSize)]];
    [bannerAd setAdSizeDelegate:self];
    [bannerAd setAdUnitId:DEMO_MN_AD_UNIT_320x50];
    [bannerAd setRootViewController:[self getTopViewController]];
    [bannerAd setDelegate:self];
    [bannerAd loadAd];
    
    [self waitForExpectationsWithTimeout:30 handler:^(NSError * _Nullable error) {
        if(error){
            NSLog(@"Test timed out! - %@", error);
        }
    }];
}

- (void)mnetAdDidLoad:(MNetAdView *)adView {
    EXPECTATION_FULFILL(self.bannerAdExpectation);
}

- (void)mnetAdDidFailToLoad:(MNetAdView *)adView withError:(MNetError *)error {
    XCTFail(@"Ad view failed! - %@", error);
    EXPECTATION_FULFILL(self.bannerAdExpectation);
}

- (void)mnetAdView:(MNetAdView *)adView didChangeSize:(MNetAdSize *)size{
    CGSize adSize = MNetCGSizeFromAdSize(size);
    [adView setFrame:CGRectMake(0.0, 0.0, adSize.width, adSize.height)];
}

@end
