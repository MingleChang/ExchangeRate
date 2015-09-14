//
//  AppDelegate.m
//  ExchangeRate
//
//  Created by 常峻玮 on 15/7/22.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import "AppDelegate.h"
#import "StartUp.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [StartUp launch];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [StartUp resignActive];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [StartUp enterBackground];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [StartUp enterForeground];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [StartUp becomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
