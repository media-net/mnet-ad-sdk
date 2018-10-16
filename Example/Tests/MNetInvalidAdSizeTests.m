//
//  MNetInvalidAdSizeTests.m
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

@interface MNetInvalidAdSizeTests : MNetTestManager<MNetAdViewDelegate, MNetAdViewSizeDelegate>
@property (nonatomic) XCTestExpectation *bannerAdViewExpectation;
@end

@implementation MNetInvalidAdSizeTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}
@end
