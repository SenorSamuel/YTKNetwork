//
//  AppDelegate.m
//  YTKNetworkDemo
//
//  Created by Chenyu Lan on 10/28/14.
//  Copyright (c) 2014 yuantiku.com. All rights reserved.
//

#import "AppDelegate.h"
#import "YTKNetworkConfig.h"
#import "YTKUrlArgumentsFilter.h"
#include <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)setupRequestFilters {
//    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.debugLogEnabled = YES;
    config.baseUrl = @"https://gateway.marvel.com:443";
    
    NSString *tsString = [NSUUID UUID].UUIDString;
    NSString *publicKey = @"d463e90161c9afc585f9224e6f53462f";
    NSString *privateKey = @"a4533e4afeb131a138444e7ac841963b4ea480ed";
    NSString *md5Hash = [self CT_MD5WithString:[NSString stringWithFormat:@"%@%@%@", tsString, privateKey, publicKey]];
    YTKUrlArgumentsFilter *urlFilter = [YTKUrlArgumentsFilter filterWithArguments:@{@"apikey": @"d463e90161c9afc585f9224e6f53462f",
                                                                                    @"ts":tsString,
                                                                                    @"hash":md5Hash}];
    [config addUrlFilter:urlFilter];
}


- (NSString *)CT_MD5WithString:(NSString *)rawStr
{
    NSData* inputData = [rawStr dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char outputData[CC_MD5_DIGEST_LENGTH];
    CC_MD5([inputData bytes], (unsigned int)[inputData length], outputData);
    
    NSMutableString* hashStr = [NSMutableString string];
    int i = 0;
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; ++i)
        [hashStr appendFormat:@"%02x", outputData[i]];
    
    return hashStr;
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupRequestFilters];
    return YES;
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
