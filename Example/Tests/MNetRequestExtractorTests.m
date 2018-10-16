//
//  MNetRequestExtractorTests.m
//  MNetAdSdk_Tests
//
//  Created by kunal.ch on 16/10/18.
//  Copyright © 2018 kunal5692. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNetTestManager.h"
#import "MNetDemoConstants.h"
#import "MNetDfpRequestEventExtractor.h"

@import GoogleMobileAds;
@import MoPub;

@interface MNetGADCustomEventMockedClass : NSObject

@property(nonatomic) GADGender userGender;

@property(nonatomic) NSDate *userBirthday;

@property(nonatomic) BOOL userHasLocation;

@property(nonatomic) CGFloat userLatitude;

@property(nonatomic) CGFloat userLongitude;

@property(nonatomic) CGFloat userLocationAccuracyInMeters;

@property(nonatomic) NSString *userLocationDescription;

@property(nonatomic) NSArray *userKeywords;

@property(nonatomic) NSDictionary *additionalParameters;


@end

@implementation MNetGADCustomEventMockedClass

@end

@interface MNetRequestExtractorTests : MNetTestManager

@end

@implementation MNetRequestExtractorTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testDFPBannerRequestEventExtractor {
    NSString *contextLink = @"https://awesome.com";
    
    NSDictionary *customTarget = @{
                                   @"bid" : @"15",
                                   @"pos" : @"b",
                                   @"value" : @"y",
                                   @"content_link" : contextLink
                                   };
    
    MNetGADCustomEventMockedClass *eventRequest = [[MNetGADCustomEventMockedClass alloc] init];
    [eventRequest setUserGender:kGADGenderMale];
    [eventRequest setUserBirthday:[NSDate dateWithTimeIntervalSince1970:0]];
    [eventRequest setUserKeywords:@[@"tom", @"jerry", @"stocks"]];
    [eventRequest setUserLongitude:LONGITUDE];
    [eventRequest setUserLatitude:LATITUDE];
    [eventRequest setUserHasLocation:YES];
    [eventRequest setAdditionalParameters:customTarget];
    
    MNetDfpExtractedData *extractedData = [MNetDfpRequestEventExtractor extractFromDfpEventRequest:eventRequest];
    
    XCTAssert([extractedData.user.gender isEqualToString:@"M"]);
    XCTAssert([extractedData.user.birthYear isEqual:[NSNumber numberWithInteger:1970]]);
    XCTAssertEqual(extractedData.location.coordinate.latitude, LATITUDE);
    XCTAssertEqual(extractedData.location.coordinate.longitude, LONGITUDE);
    XCTAssertEqual(contextLink, extractedData.contextLink);
}

- (void)testDFPBannerRequestEventExtractorWithNilContextLink {
    NSDictionary *customTarget = @{
                                   @"bid" : @"15",
                                   @"pos" : @"b",
                                   @"value" : @"y",
                                   };
    
    MNetGADCustomEventMockedClass *eventRequest = [[MNetGADCustomEventMockedClass alloc] init];
    [eventRequest setUserGender:kGADGenderMale];
    [eventRequest setUserBirthday:[NSDate dateWithTimeIntervalSince1970:0]];
    [eventRequest setUserKeywords:@[@"tom", @"jerry", @"stocks"]];
    [eventRequest setUserLongitude:LONGITUDE];
    [eventRequest setUserLatitude:LATITUDE];
    [eventRequest setUserHasLocation:YES];
    [eventRequest setAdditionalParameters:customTarget];
    
    MNetDfpExtractedData *extractedData = [MNetDfpRequestEventExtractor extractFromDfpEventRequest:eventRequest];
    
    XCTAssert([extractedData.user.gender isEqualToString:@"M"]);
    XCTAssert([extractedData.user.birthYear isEqual:[NSNumber numberWithInteger:1970]]);
    XCTAssertEqual(extractedData.location.coordinate.latitude, LATITUDE);
    XCTAssertEqual(extractedData.location.coordinate.longitude, LONGITUDE);
    XCTAssert([extractedData.contextLink isEqualToString:@""]);
}

- (void)testDFPBannerRequestEventExtractorWithNilBirthday {
    NSDictionary *customTarget = @{
                                   @"bid" : @"15",
                                   @"pos" : @"b",
                                   @"value" : @"y",
                                   };
    
    MNetGADCustomEventMockedClass *eventRequest = [[MNetGADCustomEventMockedClass alloc] init];
    [eventRequest setUserGender:kGADGenderMale];
    [eventRequest setUserBirthday:nil];
    [eventRequest setUserKeywords:@[@"tom", @"jerry", @"stocks"]];
    [eventRequest setUserLongitude:LONGITUDE];
    [eventRequest setUserLatitude:LATITUDE];
    [eventRequest setUserHasLocation:YES];
    [eventRequest setAdditionalParameters:customTarget];
    
    MNetDfpExtractedData *extractedData = [MNetDfpRequestEventExtractor extractFromDfpEventRequest:eventRequest];
    
    XCTAssert([extractedData.user.gender isEqualToString:@"M"]);
    XCTAssertEqual(extractedData.location.coordinate.latitude, LATITUDE);
    XCTAssertEqual(extractedData.location.coordinate.longitude, LONGITUDE);
    XCTAssert([extractedData.contextLink isEqualToString:@""]);
    
    XCTAssertNil(extractedData.user.birthYear);
}

- (void)testDFPBannerRequestEventExtractorWithRandomKeywords {
    NSString *contextLink = @"https://awesome.com";
    
    NSDictionary *customTarget = @{
                                   @"bid" : @"15",
                                   @"pos" : @"b",
                                   @"value" : @"y",
                                   };
    
    MNetGADCustomEventMockedClass *eventRequest = [[MNetGADCustomEventMockedClass alloc] init];
    [eventRequest setUserGender:kGADGenderMale];
    [eventRequest setUserBirthday:[NSDate dateWithTimeIntervalSince1970:0]];
    [eventRequest setUserKeywords:@[@",tom,", @"", @",stocks", [NSString stringWithFormat:@"content_link:%@", contextLink]]];
    [eventRequest setUserLongitude:LONGITUDE];
    [eventRequest setUserLatitude:LATITUDE];
    [eventRequest setUserHasLocation:YES];
    [eventRequest setAdditionalParameters:customTarget];
    
    MNetDfpExtractedData *extractedData = [MNetDfpRequestEventExtractor extractFromDfpEventRequest:eventRequest];
    
    XCTAssert([extractedData.user.gender isEqualToString:@"M"]);
    XCTAssertEqual(extractedData.location.coordinate.latitude, LATITUDE);
    XCTAssertEqual(extractedData.location.coordinate.longitude, LONGITUDE);
    XCTAssert([extractedData.contextLink isEqualToString:contextLink]);
    XCTAssert([extractedData.user.birthYear isEqual:[NSNumber numberWithInteger:1970]]);
}

- (void)testDFPBannerRequestEventExtractorWithContextLinkInKeywordsAndAdditionalParams{
    NSString *contextLink = @"https://awesome.com";
    NSString *contextLinkInAdditionalParam = @"https://additional.com";
    
    NSDictionary *customTarget = @{
                                   @"bid" : @"15",
                                   @"pos" : @"b",
                                   @"value" : @"y",
                                   @"content_link" : contextLinkInAdditionalParam
                                   };
    
    MNetGADCustomEventMockedClass *eventRequest = [[MNetGADCustomEventMockedClass alloc] init];
    [eventRequest setUserGender:kGADGenderMale];
    [eventRequest setUserBirthday:[NSDate dateWithTimeIntervalSince1970:0]];
    [eventRequest setUserKeywords:@[@",tom,", @"", @",stocks", [NSString stringWithFormat:@"content_link:%@", contextLink]]];
    [eventRequest setUserHasLocation:YES];
    [eventRequest setAdditionalParameters:customTarget];
    
    MNetDfpExtractedData *extractedData = [MNetDfpRequestEventExtractor extractFromDfpEventRequest:eventRequest];
    
    XCTAssert([extractedData.user.gender isEqualToString:@"M"]);
    XCTAssert([extractedData.contextLink isEqualToString:contextLink]);
    XCTAssert([extractedData.user.birthYear isEqual:[NSNumber numberWithInteger:1970]]);
    
    XCTAssertNil(extractedData.location);
}

@end
