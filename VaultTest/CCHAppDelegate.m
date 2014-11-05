//
//  CCHAppDelegate.m
//  VaultTest
//
//  Created by Kevin Lee on 6/26/14.
//  Copyright (c) 2014 Context Hub. All rights reserved.
//

#import "CCHAppDelegate.h"

@implementation CCHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [[ContextHub sharedInstance] setDebug:YES];
// Staging
//    NSLog(@"before");
//    [ContextHub registerWithAppId:@"9ed83d1c-a72e-4733-aefd-181cbe518a04"];
//    NSLog(@"after");
// Prod
    [ContextHub registerWithAppId:@"fafc3fd0-cbac-4196-b85a-37055ec8e514"];

    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    [[CCHSensorPipeline sharedInstance] addElementsWithTags:@[@"pipeline"]];
    
    [[CCHSensorPipeline sharedInstance] setDelegate:self];
    [[CCHSensorPipeline sharedInstance] setDataSource:self];
    return YES;
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Did fail to register: %@", error);
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[CCHPush sharedInstance] registerDeviceToken:deviceToken alias:[ContextHub deviceId] tags:@[@"integration", @"kevin", [ContextHub deviceId]] completionHandler:^(NSError *error) {
        NSLog(@"Did register");
    }];
}

//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    NSLog(@"Did receive push %@", userInfo);
//}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"Did receive push %@", userInfo);
//    [[CCHPush sharedInstance] application:application didReceiveRemoteNotification:userInfo completionHandler:^(enum UIBackgroundFetchResult result, CCHContextHubPush *CCHContextHubPush) {
//        NSLog(@"Did handle remote notification:");
//        NSLog(@"%@", CCHContextHubPush.object);
//        NSLog(@"%@", CCHContextHubPush.userInfo);
//        NSLog(@"%@", CCHContextHubPush.name);
//        completionHandler(result);
//    }];
}

- (void)sensorPipeline:(CCHSensorPipeline *)sensorPipeline didDetectEvent:(NSDictionary *)event {
    NSLog(@"Did Detect Event %@", event);
}

- (void)sensorPipeline:(CCHSensorPipeline *)sensorPipeline willPostEvent:(NSDictionary *)event {
    NSLog(@"Will Post Event %@", [event valueForKeyPath:@"event.name"]);
}

- (void)sensorPipeline:(CCHSensorPipeline *)sensorPipeline didPostEvent:(NSDictionary *)event {
    NSLog(@"Did Post Event %@", [event valueForKeyPath:@"event.name"]);
}

- (NSDictionary *)sensorPipeline:(CCHSensorPipeline *)sensorPipeline payloadForEvent:(NSDictionary *)event {
    return @{@"name":@"custom payload"};
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
