//
//  TravelingViewController.h
//  Smarty
//
//  Created by Abner Castro Aguilar on 12/12/14.
//  Copyright (c) 2014 Abner Castro Aguilar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pumabus.h"
#import "SmartyLocation.h"
#import <CoreLocation/CoreLocation.h>

@interface TravelingViewController : UIViewController <CLLocationManagerDelegate>

@property (nonatomic, strong)NSString *routeJourney;
@property (nonatomic, strong)Pumabus *pumabus;
@property (nonatomic, strong)NSArray *IDsPumabus;

@property (nonatomic, strong)CLLocation *locationUpdate;

- (IBAction)stopJourney:(UIButton *)sender;

@end
