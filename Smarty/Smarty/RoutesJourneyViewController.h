//
//  RoutesJourneyViewController.h
//  Smarty
//
//  Created by Abner Castro Aguilar on 12/12/14.
//  Copyright (c) 2014 Abner Castro Aguilar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoutesJourneyViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableRoutes;

@end
