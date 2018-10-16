//
//  MNetAppDelegate.m
//  MNetAdSdk
//
//  Created by kunal5692 on 07/11/2018.
//  Copyright (c) 2018 kunal5692. All rights reserved.
//

#import "MNetAppDelegate.h"
#import <MNetAdSdk/MNet.h>
#import <MNetAdSdk/MNetUser.h>

@import GoogleMobileAds;

@implementation MNetAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [MNet enableLogs:YES];
    MNet *mnet = [MNet initWithCustomerId:@"8CUO15940" appContainsChildDirectedContent:NO];

    // Add user details
    MNetUser *user = [[MNetUser alloc] init];
    [user addGender:MNetGenderFemale];
    [user addKeywords:@"fruits, health, energy"];
    [user addYearOfBirth:@"1985"];
    [user addName:@"Demo User"];
    [user addUserId:@"test-id"];
    [mnet setUser:user];

    [GADMobileAds configureWithApplicationID:@"ca-app-pub-6365858186554077~2677656745"];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of
    // temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application
    // and it begins the transition to the background state. Use this method to pause ongoing tasks, disable timers, and
    // throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application
    // state information to restore your application to its current state in case it is terminated later. If your
    // application supports background execution, this method is called instead of applicationWillTerminate: when the
    // user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes
    // made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application
    // was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also
    // applicationDidEnterBackground:.
}

@end
