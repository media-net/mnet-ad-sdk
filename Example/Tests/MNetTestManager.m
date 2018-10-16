//
//  MNetTestManager.m
//  MNetAdSdk_Tests
//
//  Created by kunal.ch on 26/09/18.
//  Copyright © 2018 kunal5692. All rights reserved.
//

#import "MNetTestManager.h"
#import "XCTest+MNetTestUtil.h"

@implementation MNetTestManager

- (void)setUp {
    [super setUp];
    [[LSNocilla sharedInstance] start];
    [MNet initWithCustomerId:@"test-customer-id"];
    [MNBaseAdLoaderPredictBids disablePostAdLoadPrefetch];
    [self setupClass:[self class]];
    
}

- (void)tearDown {
    [super tearDown];
    [[LSNocilla sharedInstance] stop];
}

- (UIViewController *)getTopViewController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"showad_viewcontroller"];
    [vc viewDidLoad];
    [vc viewWillAppear:NO];
    [vc viewDidAppear:NO];
    return vc;
}
@end
