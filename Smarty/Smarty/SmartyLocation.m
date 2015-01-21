//
//  SmartyLocation.m
//  Smarty
//
//  Created by Abner Castro Aguilar on 08/01/15.
//  Copyright (c) 2015 Abner Castro Aguilar. All rights reserved.
//

#import "SmartyLocation.h"

@implementation SmartyLocation

+ (SmartyLocation *)sharedInstance
{
    static SmartyLocation *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[SmartyLocation alloc] init];
    });
    
    return _sharedInstance;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.activityType = CLActivityTypeAutomotiveNavigation;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return self;
}


@end


























































































