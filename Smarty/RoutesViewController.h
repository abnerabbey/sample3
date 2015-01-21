//
//  RoutesViewController.h
//  Smarty
//
//  Created by Abner Castro Aguilar on 11/12/14.
//  Copyright (c) 2014 Abner Castro Aguilar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoutesCell.h"

@protocol RoutesSelectorDelegate <NSObject>

- (void)didRouteSelected:(NSInteger)numberRoute;

@end

@interface RoutesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableRoutes;

//Protocol's properties
@property (retain)id <RoutesSelectorDelegate> delegate;
@property NSInteger numberRoute;

@end
