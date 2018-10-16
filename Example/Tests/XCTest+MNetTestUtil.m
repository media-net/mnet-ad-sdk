//
//  XCTest+MNetTestUtil.m
//  MNetAdSdk_Tests
//
//  Created by kunal.ch on 26/09/18.
//  Copyright © 2018 kunal5692. All rights reserved.
//

#import "XCTest+MNetTestUtil.h"
#import <Nocilla/Nocilla.h>
#import <MNetBaseAdSdk/MNBaseURL.h>

static NSString *dummyAdURL = @"http://dummy-ad-url.com";
static NSString *dummyAdCode = @"<script type='text/javascript' src='http://ad-e1.media6degrees.com/adserv/csv2?tIdx3DD2473504862069428x7CDpricex3DDAAABWkZNHj7wapKf0tO-7IYRJ4UfG0bT0gIABgx7CDdIdsx3DDChEIFhINMWliNm0wcmtxZ3hxZw==x7CDblInfox3DDEi0I8IABEBcY2wYgrlYqCTUzNzEwMDE4ODIJNTM3MTAwMTg4OgBCA1dFQkoCYWQaJQoRYWVxMTA0Mi5lcS5wbC5wdnQSBDgwODAaCjE2LjExLjEzMjMylwEItMWd1bu0sgQVAADgPxgJIhFhZXExMDQyLmVxLnBsLnB2dCo2CNwJEgwI7v4GEgYzMjB4NTAYhEYg0KUBKKfZGDCCwcwBOMHeAUIJRHN0aWxsZXJ5SOQbUIRGMiQ2NDc0MjY3NC1hNDQ4LTQ3YzktYmZiYS02YWE0OTcyMDVkN2M4AkAFSgJVU1ICTUlY-QNiBTQ4MDkzx7CD' ></script>\n<iframe src='http://us-u.openx.net/w/1.0/pd?plm=5&ph=6a16560a-f6c6-4851-b7b5-0b2c0190166a' width='0' height='0' style='display:none;'></iframe>  <div id='beacon_52792' style='position:absolute;left:0px;top:0px;visibility:hidden;'>\n    <img src='http://rtb-xv.openx.net/win/medianet?p=${AUCTION_PRICE}&t=1fHJpZD01ZDQ2MGEyMy00ZWZiLTRmMzItYmMwZC03YzQwOGE1ZGJiZjl8cnQ9MTQ4NzIzODE0M3xhdWlkPTUzODY2MjMzOXxhdW09RE1JRC5XRUJ8YXVwZj1kaXNwbGF5fHNpZD01MzczMDA3OTV8cHViPTUzNzEwMDE4OHxwYz1VU0R8cmFpZD01NjZiMGY1My0xOWFkLTQxMTMtODZlMy01NzI5ZjM5NjIxNDR8cnM9M3xtd2Y9MHxhaWQ9NTM4MjM5ODA1fHQ9MTJ8YXM9MzIweDUwfGxpZD01Mzc2OTAzMDZ8b2lkPTUzNzA5NjE2MnxwPTg5MHxwcj03Mzl8YXRiPTE3NTB8YWR2PTUzNzA3MzI2NHxhYz1VU0R8cG09UFJJQ0lORy5DUE18bT0xfGFpPTE1MmQwN2IxLWRhNDEtNGM0MC1hZDE4LWZlNzRjMjY5NTM0YXxtYz1VU0R8bXI9MTUxfHBpPTczOXxtdWk9MjhjODFmZDgtNTgxZS00YjgxLWIyZmQtZmZjMzkzZTFlYTMyfG1hPTY0NzQyNjc0LWE0NDgtNDdjOS1iZmJhLTZhYTQ5NzIwNWQ3Y3xtcnQ9MTQ4NzIzODE0M3xtcmM9U1JUX1dPTnxtd2E9NTM3MDczMjY0fG13Ymk9MTkwM3xtd2I9MTc1MHxtYXA9ODkwfGVsZz0xfG1vYz1VU0R8bW9yPTE1MXxtcGM9VVNEfG1wcj03Mzl8bXBmPTE1MHxtbWY9MTUwfG1wbmY9Mjk5fG1tbmY9Mjk5fHBjdj0yMDE2MTIwMXxtbz1PWHxlYz0xMTQ1NDJ8bXB1PTczOXxtY3A9ODkwfGFxdD1ydGJ8bXdjPTUzNzA5NjE2Mnxtd3A9NTM3NjkwMzA2fG13Y3I9NTM4MjM5ODA1fHJubj0xfG13aXM9MXxtd3B0PW9wZW5ydGJfanNvbnx1cj1SVkdRNmdzRldEfGxkPWNvc21vcG9saXRhbmxhc3ZlZ2FzLmNvbQ&c=USD&s=0'/>\n  </div>\n";


@implementation XCTest (MNetTestUtil)

- (void)setupClass:(Class)className {
    [self stubifyRequests:className];
}

- (void)stubifyRequests:(Class)className {
    [self stubLoader];
    [self stubBugsnag];
    [self stubPulseRequest];
    [self stubConfigRequestForClass:className];
    [self stubPrefetchReqForclass:className];
    [self stubAdUrlRequest];
    [self stubNoAdRequestForClass:className];
    [self stubAuctionLoggerRequest];
}

#pragma mark - Request Stubs helper methods

- (void)stubLoader {
    NSString *resourceURLList = [NSString stringWithFormat:@"%@.*", [[MNBaseURL getSharedInstance] getBaseResourceUrl]];
    stubRequest(@"GET", resourceURLList.regex).withHeaders(@{@"Accept" : @"image/*"}).andReturn(200);
}

- (void)stubBugsnag {
    stubRequest(@"POST", @"https://.*?bugsnag.*".regex).andReturn(200);
}

- (void)stubConfigRequestForClass:(Class)className {
    NSString *configContents = [self readFileFromClass:className resource:FILENAME_CONFIG_FILE resourceType:@"json"];
    NSString *configUrl = [NSString stringWithFormat:@"%@.*", [[MNBaseURL getSharedInstance] getConfigUrl]];
    stubRequest(@"GET", configUrl.regex).andReturn(200).withBody(configContents);
}

- (void)stubPulseRequest {
    NSString *pulseResp = @"{\"data\": {},\"message\": \"\",\"success\": true}";
    stubRequest(@"POST", [[MNBaseURL getSharedInstance] getPulseUrl]).andReturn(200).withBody(pulseResp);
}

- (void)stubPrefetchReqForclass:(Class)className {
    NSString *respStr = [self readFileFromClass:className resource:@"MNetPredictBidsRelayResponse" resourceType:@"json"];
    
    NSString *url = [[MNBaseURL getSharedInstance] getAdLoaderPrefetchPredictBidsUrl];
    NSString *requestUrl = [NSString stringWithFormat:@"%@.*", url];
    
    stubRequest(@"GET", requestUrl.regex).andReturn(200).withBody(respStr);
    stubRequest(@"POST", requestUrl.regex).andReturn(200).withBody(respStr);
}

- (void)stubAdUrlRequest {
    stubRequest(@"GET", dummyAdURL).andReturn(200).withBody(dummyAdCode);
}

- (void)stubNoAdRequestForClass:(Class)className {
    NSString *respStr = [self readFileFromClass:className resource:@"noAdResponse" resourceType:@"json"];
    NSString *url = [[MNBaseURL getSharedInstance] getAdLoaderPredictBidsUrl];
    NSString *regexStr = [NSString stringWithFormat:@"%@.*",url];
    stubRequest(@"GET", regexStr.regex)
    .andReturn(200)
    .withBody(respStr);
    
    stubRequest(@"POST", regexStr.regex)
    .andReturn(200)
    .withBody(respStr);
}

- (void)stubAuctionLoggerRequest {
    NSString *regexURL = [NSString stringWithFormat:@"%@",[[MNBaseURL getSharedInstance] getBaseUrlDp]];
    stubRequest(@"GET", [NSString stringWithFormat:@"%@.*?/logs", regexURL].regex).andReturn(200).withBody(@"{\"success\":true, \"data\":{}}");
    stubRequest(@"POST", [NSString stringWithFormat:@"%@.*?/logs", regexURL].regex).andReturn(200).withBody(@"{\"success\":true, \"data\":{}}");
}

#pragma mark - Request Validation helper methods

- (void)validateBannerAdRequestStubForClass:(Class)className {
    NSString *respStr = [self readFileFromClass:className resource:FILENAME_BANNER_320x50 resourceType:@"json"];
    NSString *url = [[MNBaseURL getSharedInstance] getAdLoaderPredictBidsUrl];
    NSString *regexStr = [NSString stringWithFormat:@"%@.*",url];
    
    stubRequest(@"GET", regexStr.regex)
    .andReturn(200)
    .withBody(respStr);
    
    stubRequest(@"POST", regexStr.regex)
    .andReturn(200)
    .withBody(respStr);
    
    stubRequest(@"GET", @".*".regex).andReturn(200);
}

- (void)invalidBannerAdRequestStubForClass:(Class)className {
    NSString *respStr = [self readFileFromClass:className resource:FILENAME_BANNER_INVALID_SIZE resourceType:@"json"];
    NSString *url = [[MNBaseURL getSharedInstance] getAdLoaderPredictBidsUrl];
    NSString *regexStr = [NSString stringWithFormat:@"%@.*",url];
    stubRequest(@"GET", regexStr.regex)
    .andReturn(200)
    .withBody(respStr);
    
    stubRequest(@"POST", regexStr.regex)
    .andReturn(200)
    .withBody(respStr);
}

#pragma mark - File Reading Helper methods

- (NSString *)readFileFromClass:(Class)className resource:(NSString *)resourceName resourceType:(NSString *)type {
    NSString *file = [[NSBundle bundleForClass:className]
                      pathForResource:resourceName
                      ofType:type];
    
    if(!file || [file isEqualToString:@""]){
        return @"";
    }
    
    NSData *data = [NSData dataWithContentsOfFile:file];
    NSString *respStr= [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return respStr;
}
@end
