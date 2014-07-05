//
//  TPSDetailViewController.m
//  Sample-UISearchController
//
//  Created by James Dempsey on 7/4/14.
//  Copyright (c) 2014 Tapas Software. All rights reserved.
//
//  Based on Apple sample code TableSearch version 2.0
//

#import "TPSDetailViewController.h"
#import "TPSProduct.h"

@interface TPSDetailViewController ()
@end

@implementation TPSDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.product.name;
}

@end