//
//  MainViewController.h
//  Smarty
//
//  Created by Abner Castro Aguilar on 11/12/14.
//  Copyright (c) 2014 Abner Castro Aguilar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "RoutesViewController.h"

@interface MainViewController : UIViewController <MKMapViewDelegate, RoutesSelectorDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *routesButton;
@property (weak, nonatomic) IBOutlet MKMapView *mapUser;




@end
