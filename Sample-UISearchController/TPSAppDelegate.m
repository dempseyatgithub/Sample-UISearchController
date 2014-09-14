//
//  TPSAppDelegate.m
//  Sample-UISearchController
//
//  Created by James Dempsey on 7/4/14.
//  Copyright (c) 2014 Tapas Software. All rights reserved.
//
//  Based on Apple sample code TableSearch version 2.0
//

#import "TPSAppDelegate.h"
#import "TPSMasterViewController.h"
#import "TPSProduct.h"

@interface TPSAppDelegate ()
@end

@implementation TPSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    UINavigationController *navigationController = (UINavigationController *)[self.window rootViewController];
    TPSMasterViewController *viewController = [navigationController.viewControllers objectAtIndex:0];
    viewController.products = [TPSProduct allProducts];

    return YES;
}

@end
