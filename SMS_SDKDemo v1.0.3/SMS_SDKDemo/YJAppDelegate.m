//
//  YJAppDelegate.m
//  SMS_SDKDemo
//
//  Created by 严军 on 14-6-27.
//  Copyright (c) 2014年 严军. All rights reserved.
//

#import "YJAppDelegate.h"
#import "YJViewController.h"
#import <SMS_SDK/SMS_SDK.h>

//申请 http://dashboard.mob.com/index.php/Sms#/ 这里申请 注意：是在短信验证SDK后台申请
//注意:请用户自己填入所申请的短信SDK的appkey和appsecret
#define appKey @"25a64c839b5f"
#define appSecret @"9a639150fcb464d9a1c1ab926648ca3f"


@implementation YJAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //初始化短信SDK
    [SMS_SDK registerApp:appKey withSecret:appSecret];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    YJViewController* yj=[[YJViewController alloc] init];
    self.window.rootViewController=yj;
    
    [self.window makeKeyAndVisible];
    return YES;
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
