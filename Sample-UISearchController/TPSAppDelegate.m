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
    NSArray *productArray = @[[TPSProduct productWithType:ProductTypeDevice name:@"iPhone"],
                              [TPSProduct productWithType:ProductTypeDevice name:@"iPod"],
                              [TPSProduct productWithType:ProductTypeDevice name:@"iPod touch"],
                              [TPSProduct productWithType:ProductTypeDevice name:@"iPad"],
                              [TPSProduct productWithType:ProductTypeDevice name:@"iPad mini"],
                              [TPSProduct productWithType:ProductTypeDevice name:@"iPad Air"],
                              [TPSProduct productWithType:ProductTypeDesktop name:@"iMac"],
                              [TPSProduct productWithType:ProductTypeDesktop name:@"Mac Pro"],
                              [TPSProduct productWithType:ProductTypeDesktop name:@"Mac mini"],
                              [TPSProduct productWithType:ProductTypePortable name:@"MacBook"],
                              [TPSProduct productWithType:ProductTypePortable name:@"MacBook Air"],
                              [TPSProduct productWithType:ProductTypePortable name:@"MacBook Pro"]];

    UINavigationController *navigationController = (UINavigationController *)[self.window rootViewController];
    TPSMasterViewController *viewController = [navigationController.viewControllers objectAtIndex:0];
    viewController.products = productArray;

    return YES;
}

@end
