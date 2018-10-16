//
//  MNetBannerFailTests.m
//  MNetAdSdk_Tests
//
//  Created by kunal.ch on 26/09/18.
//  Copyright © 2018 kunal5692. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNetTestManager.h"
#import "XCTest+MNetTestUtil.h"
#import <MNetAdSdk/MNetAdView.h>
#import "MNetDemoConstants.h"
#import <MNetAdSdk/MNetAdSize+Internal.h>

@interface MNetBannerFailTests : MNetTestManager<MNetAdViewDelegate, MNetAdViewSizeDelegate>
@property (nonatomic) XCTestExpectation *bannerAdExpectation;
@end

@implementation MNetBannerFailTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testExample {
}

- (void)testBannerNoAd {
    self.bannerAdExpectation = [self expectationWithDescription:@"Ad view not loaded"];
    MNetAdView *bannerAd = [[MNetAdView alloc] init];
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

// Here the response will have 320x50, but the adview frame is 200x300
// So the request should fail as the adview cannot handle response frame
- (void)testBannerAdLoadWithInvalidAdViewFrame{
    [self validateBannerAdRequestStubForClass:[self class]];
    
    self.bannerAdExpectation = [self expectationWithDescription:@"Ad view loaded"];
    
    UIViewController *vc = [self getTopViewController];
    MNetAdView *bannerAd = [[MNetAdView alloc] init];
    [bannerAd setAdSizes: @[MNetCreateAdSizeFromCGSize(kMNetMediumAdSize), MNetCreateAdSizeFromCGSize(kMNetBannerAdSize)]];
    [bannerAd setAdSizeDelegate:self];
    [bannerAd setAdUnitId:DEMO_MN_AD_UNIT_320x50];
    [bannerAd setRootViewController:vc];
    [bannerAd setDelegate:self];
    
    [vc.view addSubview:bannerAd];
    [bannerAd setFrame:CGRectMake(0, 0, 200, 300)];
    [bannerAd loadAd];
    
    [self waitForExpectationsWithTimeout:30 handler:^(NSError * _Nullable error) {
        if(error){
            NSLog(@"Test timed out! - %@", error);
        }
    }];
}

// In this case the response will have ad size that device cannot handle, so the test should fail
- (void)testBannerAdLoadWithInvalidAdSizeInResponse{
    [self invalidBannerAdRequestStubForClass:[self class]];
    self.bannerAdExpectation = [self expectationWithDescription:@"Ad view loaded"];
    
    UIViewController *vc = [self getTopViewController];
    MNetAdView *bannerAd = [[MNetAdView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    [bannerAd setAdSizes: @[MNetCreateAdSizeFromCGSize(kMNetMediumAdSize), MNetCreateAdSizeFromCGSize(kMNetBannerAdSize)]];
    [bannerAd setAdSizeDelegate:self];
    [bannerAd setAdUnitId:DEMO_MN_AD_UNIT_320x50];
    [bannerAd setRootViewController:vc];
    [bannerAd setDelegate:self];
    
    [vc.view addSubview:bannerAd];
    [bannerAd loadAd];
    
    [self waitForExpectationsWithTimeout:30 handler:^(NSError * _Nullable error) {
        if(error){
            NSLog(@"Test timed out! - %@", error);
        }
    }];
}

-(void)mnetAdDidLoad:(MNetAdView *)adView{
    XCTFail(@"Ad should fail with invalid ad size error");
    EXPECTATION_FULFILL(self.bannerAdExpectation);
}

- (void)mnetAdDidFailToLoad:(MNetAdView *)adView withError:(MNetError *)error{
    NSLog(@"Error : %@", [error getErrorReasonString]);
    EXPECTATION_FULFILL(self.bannerAdExpectation);
}

- (void)mnetAdView:(nonnull MNetAdView *)adView didChangeSize:(nonnull MNetAdSize *)size {
    // Not setting adview frame here as we are testing for fail cases
}

@end
