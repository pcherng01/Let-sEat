//
//  AppDelegate.m
//  LetsEat
//
//  Created by Monte's Pro 13" on 10/9/15.
//  Copyright © 2015 Monte Thakkar. All rights reserved.
//

#import "AppDelegate.h"
#import "Constants.h"
#import <Parse/Parse.h>
#import <Stripe/Stripe.h>

@implementation AppDelegate
{
   NSData *deviceTokenData;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // [Optional] Power your app with Local Datastore. For more info, go to
    // https://parse.com/docs/ios_guide#localdatastore/iOS
    [Parse enableLocalDatastore];
    
    // Initialize Parse.
    [Parse setApplicationId:@"c2TKa2Ywg5BlwI3e6fB2f7WMzFs5oxxhlNrzTs4y"
                  clientKey:@"SXhVtoEv2IwYNNaqOTArlOZkgvsdZx3KpMc8xksm"];
   
   UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                   UIUserNotificationTypeBadge |
                                                   UIUserNotificationTypeSound);
   UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                            categories:nil];
   [application registerUserNotificationSettings:settings];
   [application registerForRemoteNotifications];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    if (StripePublishableKey) {
        [Stripe setDefaultPublishableKey:StripePublishableKey];
    }
    
    return YES;
}

-(NSData *)returnData {
   return deviceTokenData;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
   // Store the deviceToken in the current installation and save it to Parse.
   PFInstallation *currentInstallation = [PFInstallation currentInstallation];
   [currentInstallation setDeviceTokenFromData:deviceToken];
   deviceTokenData = deviceToken;
   
   /*
   PFQuery *pushQuery = [PFInstallation query];
   [pushQuery whereKey:@"deviceType" equalTo:@"ios"];
   
   // Send push notification to query
   [PFPush sendPushMessageToQueryInBackground:pushQuery
                                  withMessage:@"Hello World!"];*/
   currentInstallation.channels = @[ @"global" ];
   [currentInstallation saveInBackground];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
   [PFPush handlePush:userInfo];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
