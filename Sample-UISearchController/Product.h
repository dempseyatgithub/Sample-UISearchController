//
//  TPSProduct.h
//  Sample-UISearchController
//
//  Created by James Dempsey on 7/4/14.
//  Copyright (c) 2014 Tapas Software. All rights reserved.
//
//  Based on Apple sample code TableSearch version 2.0
//

#import <Foundation/Foundation.h>

extern NSString *const ProductTypeDevice;
extern NSString *const ProductTypeDesktop;
extern NSString *const ProductTypePortable;

@interface Product : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;

+ (NSArray *)allProducts;

+ (instancetype)productWithType:(NSString *)type name:(NSString *)name;

+ (NSArray *)deviceTypeNames;
+ (NSString *)displayNameForType:(NSString *)type;

@end
