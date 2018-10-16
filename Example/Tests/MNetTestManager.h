//
//  MNetTestManager.h
//  MNetAdSdk_Tests
//
//  Created by kunal.ch on 26/09/18.
//  Copyright © 2018 kunal5692. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MNetAdSdk/MNet.h>
#import <Nocilla/Nocilla.h>

@import MNetBaseAdSdk;
@import MNetJSONModeller;

#define EXPECTATION_FULFILL(EXPECTATION) \
if(EXPECTATION){\
[EXPECTATION fulfill];\
EXPECTATION = nil;\
}

@interface MNetTestManager : XCTestCase

- (void)setUp;
- (void)tearDown;
- (UIViewController *)getTopViewController;
@end
