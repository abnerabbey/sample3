//
//  SmartyLocation.h
//  Smarty
//
//  Created by Abner Castro Aguilar on 08/01/15.
//  Copyright (c) 2015 Abner Castro Aguilar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface SmartyLocation : NSObject <CLLocationManagerDelegate>

@property (nonatomic, strong)CLLocationManager *locationManager;
@property (nonatomic, strong)CLLocation *location;


+ (SmartyLocation *)sharedInstance;

@end
