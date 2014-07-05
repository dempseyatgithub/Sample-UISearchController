//
//  TPSProduct.m
//  Sample-UISearchController
//
//  Created by James Dempsey on 7/4/14.
//  Copyright (c) 2014 Tapas Software. All rights reserved.
//
//  Based on Apple sample code TableSearch version 2.0
//

#import "TPSProduct.h"

NSString *const ProductTypeDevice = @"Device";
NSString *const ProductTypeDesktop = @"Desktop";
NSString *const ProductTypePortable = @"Portable";

@implementation TPSProduct

+ (instancetype)productWithType:(NSString *)type name:(NSString *)name {
    TPSProduct *newProduct = [[self alloc] init];
    newProduct.type = type;
    newProduct.name = name;
    return newProduct;
}


+ (NSArray *)deviceTypeNames {
    static NSArray *deviceTypeNames = nil;
    static dispatch_once_t once;

    dispatch_once(&once, ^{
        deviceTypeNames = @[ProductTypeDevice, ProductTypePortable, ProductTypeDesktop];
    });

    return deviceTypeNames;
}


+ (NSString *)displayNameForType:(NSString *)type {
    static NSMutableDictionary *deviceTypeDisplayNamesDictionary = nil;
    static dispatch_once_t once;

    dispatch_once(&once, ^{
        deviceTypeDisplayNamesDictionary = [[NSMutableDictionary alloc] init];
        for (NSString *deviceType in self.deviceTypeNames) {
            NSString *displayName = NSLocalizedString(deviceType, @"dynamic");
            deviceTypeDisplayNamesDictionary[deviceType] = displayName;
        }
    });

    return deviceTypeDisplayNamesDictionary[type];
}


static NSString *const NameKey = @"NameKey";
static NSString *const TypeKey = @"TypeKey";

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _name = [aDecoder decodeObjectForKey:NameKey];
        _type = [aDecoder decodeObjectForKey:TypeKey];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:NameKey];
    [aCoder encodeObject:self.type forKey:TypeKey];
}

@end